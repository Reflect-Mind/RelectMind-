--数据库 psychoVocab.db
--最后修改时间：2018/1/30 17:53

----主题表
create table theme(
	id integer primary key autoincrement,	--id，主键，由自增序列构成
	content varchar2(255) unique,					--所属主题分类(自我和谐, 积极, 消极)
	belongto text							--主题描述(基调分析、主题分析、人格分析、自我认同分析)							
)
/

----词汇分类表
create table category(
	id integer primary key autoincrement,	--id，主键，由自增序列构成
	content varchar2(255) unique,					--某词汇指向的分类(例：坚强的 ---> 自我指向)
	themeId integer,											--主题id，此外键关联到主题表中的主键
	foreign key(themeId) references theme(id)
)
/

----词汇表
create table vocab(
	id integer primary key autoincrement,	--id，主键，由自增序列构成
	content varchar2(255), 				--具体的词汇
	status integer, 											--0是为非停用词,1为停用词
	wordlen integer,											--单词的长度
	appearnum integer,										--单词的出现次数
  frq decimal(10,4),										--单词的频率
	solid decimal(10,4),									--单词的凝固程度
	entropy decimal(10,4),								--单词的信息熵	
	categoryId integer,										--分类id，此外键关联到分类表中的主键	
	unique(content, categoryId)
	foreign key(categoryId) references category(id)
)
/

----日志表
create table vocabLog(
	id integer primary key autoincrement,	--id，主键，由自增序列构成
	charnum integer,											--当前文本字数
	recognum integer,											--当前识词数
	newnum integer,												--当前新词数
	filename varchar(255),								--当前文件名
	addtime varchar(255),									--添加时间
	taketime decimal(10,4)								--耗时	
)
/

--单字视图
create view character as
select id, content, appearnum, frq, entropy
from vocab where wordlen = 1;


-------------------------------------------------------------------------------------
问题汇总：
1.程序是先学习新词再识词，还是先识词再学习新词？

-------------------------------------------------------------------------------------
--按照字典序进行排序
alter index vocab_content_index 
on vocab(content desc);