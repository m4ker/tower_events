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
    status
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
    has_many: user, through: :members
    has_many: products
    has_many: events
    
user
    has_many: teams, through: :members
    belongs_to: project, through: :accesses
    has_many: events
    has_many: todos
    has_many: comments

project
    belongs_to: team
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
