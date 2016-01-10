# Tower Events

这是一个小测试

## 任务要求

- 实现动态页面关于「任务」的数据展示(对页面样式无要求),可以持续加载;
- 设计 Event(动态模型),以及其它所需的基础模型;
- 设计并完成 events_controller#index 接口,该接口返回回顾页面的数据,默认 50 条;
- 尽可能的使用 Rspec 完成 Model 层以及 Controller 层的测试用例。

## 任务分析

- 动态页面 对 团队所有成员 在 模型 上 的 绝大多数 操作 进行展示
- 页面内的数据有 三种 加载方式: 1. 服务端渲染首屏 2. 滚屏加载更多 3. websocket即时更新

### 动态展示的内容

<pre>

team 没有动态
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
      created_at: 2016-01-01 00:00:00
      updated_at: 2016-01-01 00:00:00
    bobhero:
      id: 2
      email: bobhero@gmail.com
      name: bobhero
      created_at: 2016-01-01 00:00:00
      updated_at: 2016-01-01 00:00:00
    rockingpanda:
      id: 3
      email: rockingpanda@gmail.com
      name: rockingpanda
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
      action:comment
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
      action:comment
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
      action:comment
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
      action:comment
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
      action:comment
      object:todo
      object_id:8
      title:任务3-8
      content:评论3-8内容8—2
      data:
      created_at: 2016-01-03 18:00:00
      updated_at: 2016-01-03 18:00:00

</pre>




  

