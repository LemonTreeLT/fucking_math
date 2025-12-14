# fucking_math

A new Flutter project.

## 开发线路

- 英语部分
    - 记录单词
        - 存储：使用drift+sqlite
            - 编写初始化数据库相关功能 DONE
    - 单词听写表

- 知识点库
    - Q: 我需要做成多学科的吗？或者全部集成在一个库中？  
        A: 在一个库中通过 enum 枚举类型，若有更加复杂的科目管理需求，通过创建科目扩展库动态链接即可
    - 表结构
        - id, subject(enum), head, body, addat(time)
        - 通过log表管理编辑记录? -YES
    - log表(目前仅有编辑记录，保存type类型以备扩展)
        - id, knowledgeID,time, type, notes
        - type(enum): edit

    
- tag库
    - 表结构
        - id, subject(optional), tag, description,
