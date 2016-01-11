# DataBaseStore
## Version 1.0 (暂不支持多表查询)
### DataBaseStore 是对SQLite的一个封装，依赖第三方库FMDB。 每一个表对应一个 Table（业务数据字段） 和 Record（业务数据对象）”,简单的说让一个对象映射了一个数据库里的表。<br/>同一业务对应一个DataCenter，底层CURD(<font color=red size=5>C</font>reate <font color=red size=5>U</font>pdate <font color=red size=5>R</font>ead <font color=red size=5>D</font>elete)操作与业务隔离。
<br/>

---

### 下一步(Version 2.0)：
### 增加多表查询功能以及AOP



