# Tower Events

这是一个小测试, 可能会改变我的生活.

## 任务要求

- 实现动态页面关于「任务」的数据展示(对页面样式无要求),可以持续加载;
- 设计 Event(动态模型),以及其它所需的基础模型;
- 设计并完成 events_controller#index 接口,该接口返回回顾页面的数据,默认 50 条;
- 尽可能的使用 Rspec 完成 Model 层以及 Controller 层的测试用例。

## 任务分析

- 动态页面 对 团队所有成员 在 模型 上 的 绝大多数 操作 进行展示
- 页面内的数据有 三种 加载方式: 

1. 服务端渲染首屏 
2. 滚屏加载更多 https://tower.im/teams/87723fa675c84fb28db2433833f107ef/events/?conn_guid=3cacc59463fa78481e680cb235ca60b1&till_id=41540038
3. websocket即时更新

<!--
S: {"event":"pusher:connection_established","data":{"socket_id":"c3b2d538-c5df-4d76-a4e4-bf074f45dcbb","activity_timeout":120}}
C: {"event":"pusher:subscribe","data":{"auth":"bb025b016f19e1824544289f1246f0b1:58f86849f7ac18d00b51c4e7ac7b81c1e29f6821f04c64c8b4ced1aa5c25a713","channel":"private-member-58602"}}
S: {"event":"pusher_internal:subscription_succeeded","data":{},"channel":"private-member-58602"}
S: {"event":"todo","data":"{\"html\":\"\\n<li class=\\\"todo completed\\\"\\n    data-guid=\\\"88ff4b88a1dc4696bfe804988b0d53b7\\\"\\n    data-sort=\\\"1024.0\\\"\\n    data-sequence-mine=\\\"1024.0\\\"\\n    data-sort-url=\\\"/projects/8c95ca25df6a4685b94a37d763691611/todos/88ff4b88a1dc4696bfe804988b0d53b7/reorder?proto=https\\\"\\n    data-project-guid=\\\"8c95ca25df6a4685b94a37d763691611\\\" data-project-name=\\\"test22\\\"\\n    data-creator-guid=\\\"ce0f6b7fd89e42349253834d2dfcefc1\\\"\\n    data-updated-at=\\\"1452525574\\\"\\n    data-closed-at=\\\"1452525574\\\">\\n\\n    <div class=\\\"todo-actions actions\\\">\\n        <div class=\\\"inr\\\">\\n            <a href=\\\"/projects/8c95ca25df6a4685b94a37d763691611/todos/88ff4b88a1dc4696bfe804988b0d53b7/destroy\\\" data-visible-to=\\\"creator,admin\\\"\\n                class=\\\"del\\\" data-remote=\\\"true\\\" data-method=\\\"post\\\" data-confirm=\\\"确定要删除这条任务吗？\\\" title=\\\"删除\\\">删除</a>\\n        </div>\\n    </div>\\n\\n    <div class=\\\"todo-wrap\\\">\\n        <input type=\\\"checkbox\\\" name=\\\"todo-done\\\" checked />\\n\\n\\n        <span class=\\\"todo-content\\\">\\n            <span class=\\\"raw\\\">我是一个老任务</span>\\n            <span class=\\\"content-non-linkable\\\">\\n                <span class=\\\"todo-rest\\\">我是一个老任务</span>\\n            </span>\\n            <span class=\\\"content-linkable\\\">\\n                <a href=\\\"/projects/8c95ca25df6a4685b94a37d763691611/todos/88ff4b88a1dc4696bfe804988b0d53b7?proto=https\\\" class=\\\"todo-rest\\\" data-stack=\\\"true\\\">我是一个老任务</a>\\n            </span>\\n        </span>\\n\\n        <span class=\\\"todo-detail\\\">\\n                <span class=\\\"label completed-member\\\">( maker <span class=\\\"completed-time\\\" data-readable-time=\\\"2016-01-11T23:19:34+08:00\\\"></span> )</span>\\n        </span>\\n\\n        <a href=\\\"/projects/8c95ca25df6a4685b94a37d763691611/lists/376619505c694bc195b8c016533f9db5/show?proto=https\\\" class=\\\"label todo-proj\\\" data-stack=\\\"true\\\" title=\\\"test22 - 修复\\\">test22 - 修复</a>\\n    </div>\\n</li>\\n\",\"guid\":\"88ff4b88a1dc4696bfe804988b0d53b7\",\"op\":\"update\",\"list\":\"376619505c694bc195b8c016533f9db5\",\"desc\":\"\",\"conn_guid\":\"87957f985953761a6a0b0ccfb566e230\",\"project_guid\":\"8c95ca25df6a4685b94a37d763691611\",\"project_name\":\"test22\"}","channel":"private-member-58602"}
S: {"event":"progress","data":"{\"html\":\"\\n    <div class=\\\"activity activity-action 33\\\" data-member-guid=\\\"ce0f6b7fd89e42349253834d2dfcefc1\\\" data-progress-id=\\\"44302136\\\">\\n        <span class=\\\"time\\\">23:19</span>\\n        <span class=\\\"datetime\\\">2016-01-11 23:19</span>\\n        <div class=\\\"action\\\">\\n            <a class=\\\"member\\\" data-stack data-stack-root href=\\\"/members/ce0f6b7fd89e42349253834d2dfcefc1?proto=https\\\"><img class=\\\"avatar\\\" src=\\\"/assets/default_avatars/waves.jpg\\\" alt=\\\"maker\\\" /></a>\\n            <div class=\\\"title\\\">\\n                <em><a data-stack data-stack-root href=\\\"/members/ce0f6b7fd89e42349253834d2dfcefc1?proto=https\\\">maker</a></em>\\n                    完成了任务\\n                <span class=\\\"sp\\\">：</span>\\n            </div>\\n            <div class=\\\"target target-\\\">\\n                    <a data-stack data-stack-root data-parent-name=\\\"test22\\\" data-parent-url=\\\"/projects/8c95ca25df6a4685b94a37d763691611/\\\" href=\\\"/projects/8c95ca25df6a4685b94a37d763691611/todos/88ff4b88a1dc4696bfe804988b0d53b7?proto=https\\\" title=\\\"我是一个老任务\\\">我是一个老任务</a>\\n            </div>\\n        </div>\\n    </div>\\n\\n\\n\\n\",\"project\":{\"name\":\"test22\",\"guid\":\"8c95ca25df6a4685b94a37d763691611\",\"path\":\"/projects/8c95ca25df6a4685b94a37d763691611\"}}","channel":"private-member-58602"}
S: {"event":"event","data":"{\"html\":\"\\n<div class=\\\"event event-common event-todo-close\\\" id=\\\"event-42160656\\\"\\n    data-ancestor-guid=\\\"8c95ca25df6a4685b94a37d763691611\\\"\\n    data-ancestor-name=\\\"test22\\\"\\n    data-ancestor-url=\\\"/projects/8c95ca25df6a4685b94a37d763691611?proto=https\\\">\\n\\n\\t<a href=\\\"/members/ce0f6b7fd89e42349253834d2dfcefc1?proto=https\\\" class=\\\"from\\\" target=\\\"_blank\\\"><img alt=\\\"maker\\\" class=\\\"avatar\\\" src=\\\"https://tower.im/assets/default_avatars/waves.jpg\\\" /></a>\\n\\t<i class=\\\"icon-event\\\"></i>\\n\\n\\t<div class=\\\"event-main\\\">\\n\\t\\t<div class=\\\"event-head\\\">\\n\\t\\t\\t<a href=\\\"#event-42160656\\\" data-created-at=\\\"2016-01-11T23:19:35+08:00\\\" class=\\\"event-created-at\\\">\\n\\t\\t\\t\\t2016-01-11 23:19\\n\\t\\t\\t</a>\\n\\t\\t\\t<span class=\\\"event-actor\\\">\\n\\t\\t\\t\\t<a href=\\\"/members/ce0f6b7fd89e42349253834d2dfcefc1?proto=https\\\" class=\\\"link-member\\\" target=\\\"_blank\\\">maker</a>\\n\\t\\t\\t</span>\\n\\t\\t\\t<span class=\\\"event-action\\\">\\n\\t\\t\\t\\t完成了任务\\n\\t\\t\\t</span>\\n\\t\\t\\t<span class=\\\"event-text\\\">\\n\\t\\t\\t\\t<span class=\\\"emphasize\\\">\\n\\t\\t\\t\\t\\t<a href=\\\"/projects/8c95ca25df6a4685b94a37d763691611/todos/88ff4b88a1dc4696bfe804988b0d53b7?proto=https\\\" class=\\\"todo-rest\\\" data-stack=\\\"true\\\">我是一个老任务</a>\\n\\t\\t\\t\\t</span>\\n\\t\\t\\t</span>\\n\\t\\t</div>\\n\\t</div>\\n</div>\\n\\n\\n\",\"event\":{\"creator\":{\"guid\":\"ce0f6b7fd89e42349253834d2dfcefc1\"},\"ancestor\":{\"guid\":\"8c95ca25df6a4685b94a37d763691611\"}}}","channel":"private-member-58602"}
C: {"event":"pusher:ping","data":{}}
S: {"event":"pusher:pong","data":{}}
-->

### 动态展示的内容

<pre>

team
    create  maker2 创建了团队  我是攻城师
project
    create  maker 创建了项目  test2
            %user 创建了项目 %title
    edit    没有动态
    delete  maker2 删除了项目  test12 
            %user 删除了项目 %title
user 没有动态
team_user 没有动态
access 没有动态
todo
    create     maker 创建了任务  任务1
                %user 创建了任务  %title
    delete     maker2 删除了任务  新的任务23
                %user 删除了任务  %title
    处理任务    maker2 开始处理这条任务  我是一个老任务
    start      %user 开始处理这条任务  %title
    暂停任务    maker2 暂停处理这条任务  我是一个老任务
    resume      %user 暂停处理这条任务  %title
    移动任务    maker2 移动了任务  新的任务23
    move        %user 移动了任务  %title
    指派任务    maker 给 maker 指派了任务  我的任务3
    designate   %user 给 %user_to 指派了任务  %title
    修改时间    maker 将任务完成时间从 没有截止日期 修改为 1月24日  我的任务3
    time        %user 将任务完成时间从 %date_from 修改为 %date_to  %title
    完成任务    maker 完成了任务  任务1
    complete    %user 完成了任务  %title
    激活任务    maker 重新打开了任务  新的任务2
    active      %user 重新打开了任务  %title
    添加描述    没有动态
    修改描述    没有动态
    修改标题    没有动态
comment
    create  maker2 回复了任务  我的任务4\n内容
            %user 回复了任务  %title\n%content
    edit    没有动态
    delete  maker2 删除了回复  新的任务2\n内容2
            %user 删除了回复  %title\n%content

</pre>

###注意事项:

- 用户改名后动态中的历史记录没有发生变动,说明动态中保存了用户名字符串
- 任务标题修改后动态中的历史记录没有发生变动,说明动态中保存了任务标题
- 项目删除后, 动态也被删除了

## 数据库结构

<pre>
team
    id
    name
    user_id
    created_at
    updated_at
user
    id
    email
    name
    avator
    created_at
    updated_at
members
    team_id
    user_id
project
    id
    team_id
    name
    created_at
    updated_at
access
    user_id
    project_id
todo
    id
    project_id
    title
    description
    user_id
    owner_id
    deadline
    status      1 初始状态 2 进行中 3 已完成
    created_at
    updated_at
comment
    id
    todo_id
    user_id
    content
    created_at
    updated_at
event
    id
    team_id
    project_id
    user_id
    username
    action
    object
    object_id
    title
    content
    data
    created_at
    updated_at
</pre>

## 模型关系

<pre>
team
    has_many: users, through: :members
    has_many: products
    has_many: events
    # belongs_to: user
    
user
    has_many: teams, through: :members
    belongs_to: project
    has_many: events
    has_many: todos
    has_many: comments

project
    belongs_to: team
    belongs_to: user
    has_many: users
    has_many: todos
    has_many: events
    
todo
    belongs_to: project
    belongs_to: user
    #belongs_to: owner
    has_many: comments
    
comment
    belongs_to: todo
    belongs_to: user
    
event
    belongs_to: team
    belongs_to: project
    belongs_to: user

</pre>

## 测试数据
<pre>
users:
    maker:
      id: 1
      email: makerwang@gmail.com
      name: maker
      avatar: https://tower.im/assets/default_avatars/waves.jpg
      created_at: 2016-01-01 00:00:00
      updated_at: 2016-01-01 00:00:00
    bobhero:
      id: 2
      email: bobhero@gmail.com
      name: bobhero
      avatar: https://tower.im/assets/default_avatars/jokul.jpg
      created_at: 2016-01-01 00:00:00
      updated_at: 2016-01-01 00:00:00
    rockingpanda:
      id: 3
      email: rockingpanda@gmail.com
      name: rockingpanda
      avatar: https://tower.im/assets/default_avatars/jokul.jpg
      created_at: 2016-01-01 00:00:00
      updated_at: 2016-01-01 00:00:00

teams:
    m4b:
      id: 1
      name: m4b
      user_id: 1
      created_at: 2016-01-01 02:00:00
      updated_at: 2016-01-01 02:00:00
    panda:
      id: 2
      name: panda
      user_id: 3
      created_at: 2016-01-01 01:00:00
      updated_at: 2016-01-01 01:00:00

members:
    one:
      team_id: 1
      user_id: 1
    two:
      team_id: 1
      user_id: 2
    three:
      team_id: 2
      user_id: 1
    four:
      team_id: 2
      user_id: 3

projects:
    snakesofchina:
      id: 1
      team_id: 1
      user_id: 1
      name: snakesofchina
      created_at: 2016-01-01 03:00:00
      updated_at: 2016-01-01 03:00:00
    koa:
      id: 2
      team_id: 1
      user_id: 1
      name: koa
      created_at: 2016-01-01 04:00:00
      updated_at: 2016-01-01 04:00:00
    autotab:
      id: 3
      team_id: 2
      user_id: 3
      name: autotab
      created_at: 2016-01-01 05:00:00
      updated_at: 2016-01-01 05:00:00
access
    one:
      user_id: 1
      project_id: 1
    two:
      user_id: 1
      project_id: 2
    three:
      user_id: 1
      project_id: 3
    four:
      user_id: 2
      project_id: 2
    five:
      user_id: 3
      project_id: 3
todo
    p1_1:
      id: 1
      project_id: 1
      title: 任务1-1
      description: 任务1的描述
      user_id: 1
      owner_id: 1
      deadline: 2016-01-02
      status: 3
      created_at: 2016-01-01 03:30:00
      updated_at: 2016-01-01 03:30:00
    p1_2:
      id: 2
      project_id: 1
      title: 任务1-2
      description: 任务2的描述
      user_id: 1
      owner_id: 1
      deadline: 2016-01-02
      status: 3
      created_at: 2016-01-01 04:00:00
      updated_at: 2016-01-01 04:00:00
    p1_3:
      id: 3
      project_id: 1
      title: 任务1-3
      description: 任务3的描述
      user_id: 1
      owner_id: 1
      deadline: 2016-01-02
      status: 3
      created_at: 2016-01-02 05:00:00
      updated_at: 2016-01-02 05:00:00
    p2_1:
      id: 4
      project_id: 2
      title: 任务2-4
      description: 任务4的描述
      user_id: 2
      owner_id: 2
      deadline: 2016-01-02
      status: 3
      created_at: 2016-01-02 06:00:00
      updated_at: 2016-01-02 06:00:00
    p1_5:
      id: 5
      project_id: 1
      title: 任务1-5
      description: 任务5的描述
      user_id: 1
      owner_id: 1
      deadline: 2016-01-02
      status: 3
      created_at: 2016-01-02 07:00:00
      updated_at: 2016-01-02 07:00:00
    p1_6:
      id: 6
      project_id: 1
      title: 任务1-6
      description: 任务6的描述
      user_id: 1
      owner_id: 1
      deadline: 2016-01-03
      status: 3
      created_at: 2016-01-02 08:00:00
      updated_at: 2016-01-02 08:00:00
    p3_7:
      id: 7
      project_id: 3
      title: 任务3-7
      description: 任务7的描述
      user_id: 1
      owner_id: 1
      deadline: 2016-01-04
      status: 3
      created_at: 2016-01-03 09:00:00
      updated_at: 2016-01-03 09:00:00
    p3_8:
      id: 8
      project_id: 3
      title: 任务3-8
      description: 任务8的描述
      user_id: 3
      owner_id: 3
      deadline: 2016-01-05
      status: 3
      created_at: 2016-01-03 10:00:00
      updated_at: 2016-01-03 10:00:00
    p2_2:
      id: 9
      project_id: 2
      title: 任务2-9
      description: 任务9的描述
      user_id: 1
      owner_id: 2
      deadline: 2016-01-06
      status: 3
      created_at: 2016-01-03 11:00:00
      updated_at: 2016-01-03 11:00:00
    p2_3:
      id: 10
      project_id: 2
      title: 任务2-10
      description: 任务10的描述
      user_id: 2
      owner_id: 1
      deadline: 2016-01-06
      status: 3
      created_at: 2016-01-03 12:00:00
      updated_at: 2016-01-03 12:00:00
    

comment
    c4_1:
      id: 1
      todo_id: 4
      user_id: 2
      content: 评论2-1内容4—1
      created_at: 2016-01-02 07:00:00
      updated_at: 2016-01-02 07:00:00
    c4_2:
      id: 2
      todo_id: 4
      user_id: 1
      content: 评论2-1内容4—2
      created_at: 2016-01-02 08:00:00
      updated_at: 2016-01-02 08:00:00
    c4_3:
      id: 3
      todo_id: 4
      user_id: 2
      content: 评论2-1内容4—3
      created_at: 2016-01-02 09:00:00
      updated_at: 2016-01-02 09:00:00
    c8_1:
      id: 4
      todo_id: 8
      user_id: 3
      content: 评论3-8内容8—1
      created_at: 2016-01-03 17:00:00
      updated_at: 2016-01-03 17:00:00
    c8_2:
      id: 5
      todo_id: 8
      user_id: 1
      content: 评论3-8内容8—2
      created_at: 2016-01-03 18:00:00
      updated_at: 2016-01-03 18:00:00
      
event
    e_1:
      id:1
      team_id:1
      project_id:1
      user_id:1
      username:maker
      action:create
      object:project
      object_id:1
      title:snakesofchina
      content:
      data:
      created_at: 2016-01-01 03:00:00
      updated_at: 2016-01-01 03:00:00
    e_2:
      id:2
      team_id:1
      project_id:1
      user_id:1
      username:maker
      action:create
      object:todo
      object_id:1
      title:任务1-1
      content:
      data:
      created_at: 2016-01-01 03:30:00
      updated_at: 2016-01-01 03:30:00
    e_3:
      id:3
      team_id:1
      project_id:2
      user_id:1
      username:maker
      action:create
      object:project
      object_id:2
      title:koa
      content:
      data:
      created_at: 2016-01-01 04:00:00
      updated_at: 2016-01-01 04:00:00
    e_4:
      id:4
      team_id:1
      project_id:1
      user_id:1
      username:maker
      action:create
      object:todo
      object_id:2
      title:任务1-2
      content:
      data:
      created_at: 2016-01-01 04:00:00
      updated_at: 2016-01-01 04:00:00
    e_5:
      id:5
      team_id:2
      project_id:3
      user_id:3
      username:rockingpanda
      action:create
      object:project
      object_id:3
      title:autotab
      content:
      data:
      created_at: 2016-01-01 05:00:00
      updated_at: 2016-01-01 05:00:00
    e_6:
      id:6
      team_id:1
      project_id:1
      user_id:1
      username:maker
      action:create
      object:todo
      object_id:3
      title:任务1-3
      content:
      data:
      created_at: 2016-01-02 05:00:00
      updated_at: 2016-01-02 05:00:00
    e_7:
      id:7
      team_id:1
      project_id:2
      user_id:2
      username:bobhero
      action:create
      object:todo
      object_id:4
      title:任务2-4
      content:
      data:
      created_at: 2016-01-02 06:00:00
      updated_at: 2016-01-02 06:00:00
    e_8:
      id:8
      team_id:1
      project_id:1
      user_id:1
      username:maker
      action:create
      object:todo
      object_id:5
      title:任务1-5
      content:
      data:
      created_at: 2016-01-02 07:00:00
      updated_at: 2016-01-02 07:00:00
    e_9:
      id:9
      team_id:1
      project_id:2
      user_id:2
      username:bobhero
      action:comment.create
      object:todo
      object_id:4
      title:任务1-4
      content:评论2-1内容4—1
      data:
      created_at: 2016-01-02 07:00:00
      updated_at: 2016-01-02 07:00:00
    e_10:
      id:10
      team_id:1
      project_id:1
      user_id:1
      username:maker
      action:create
      object:todo
      object_id:6
      title:任务1-6
      content:
      data:
      created_at: 2016-01-02 08:00:00
      updated_at: 2016-01-02 08:00:00
    e_11:
      id:11
      team_id:1
      project_id:2
      user_id:1
      username:maker
      action:comment.create
      object:todo
      object_id:4
      title:任务1-4
      content:评论2-1内容4—2
      data:
      created_at: 2016-01-02 08:00:00
      updated_at: 2016-01-02 08:00:00
    e_12:
      id:12
      team_id:2
      project_id:3
      user_id:1
      username:maker
      action:create
      object:todo
      object_id:7
      title:任务3-7
      content:
      data:
      created_at: 2016-01-03 09:00:00
      updated_at: 2016-01-03 09:00:00
    e_13:
      id:13
      team_id:1
      project_id:2
      user_id:2
      username:bobhero
      action:comment.create
      object:todo
      object_id:4
      title:任务1-4
      content:评论2-1内容4—3
      data:
      created_at: 2016-01-02 09:00:00
      updated_at: 2016-01-02 09:00:00
    e_14:
      id:14
      team_id:2
      project_id:3
      user_id:3
      username:rockingpanda
      action:create
      object:todo
      object_id:8
      title:任务3-8
      content:
      data:
      created_at: 2016-01-03 10:00:00
      updated_at: 2016-01-03 10:00:00
    e_15:
      id:15
      team_id:1
      project_id:2
      user_id:1
      username:maker
      action:create
      object:todo
      object_id:9
      title:任务2-9
      content:
      data:
      created_at: 2016-01-03 11:00:00
      updated_at: 2016-01-03 11:00:00
    e_16:
      id:16
      team_id:1
      project_id:2
      user_id:2
      username:bobhero
      action:create
      object:todo
      object_id:10
      title:任务2-10
      content:
      data:
      created_at: 2016-01-03 12:00:00
      updated_at: 2016-01-03 12:00:00
    e_17:
      id:17
      team_id:2
      project_id:3
      user_id:3
      username:rockingpanda
      action:comment.create
      object:todo
      object_id:8
      title:任务3-8
      content:评论3-8内容8—1
      data:
      created_at: 2016-01-03 17:00:00
      updated_at: 2016-01-03 17:00:00
    e_18:
      id:18
      team_id:2
      project_id:3
      user_id:1
      username:maker
      action:comment.create
      object:todo
      object_id:8
      title:任务3-8
      content:评论3-8内容8—2
      data:
      created_at: 2016-01-03 18:00:00
      updated_at: 2016-01-03 18:00:00

</pre>




  

