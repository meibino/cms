DROP DATABASE IF EXISTS cms;
CREATE DATABASE cms;
USE cms;

SET FOREIGN_KEY_CHECKS=0;

-- 1、学院表
DROP TABLE IF EXISTS college;
CREATE TABLE college (
  college_id       int(11)        NOT NULL,
  college_name     varchar(200)   NOT NULL COMMENT '课程名',
  PRIMARY KEY (college_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO college VALUES ('1', '计算机系');
INSERT INTO college VALUES ('2', '设计系');
INSERT INTO college VALUES ('3', '财经系');

-- 2. 课程表
DROP TABLE IF EXISTS course;
CREATE TABLE course (
  course_id        int(11)        NOT NULL,
  course_name      varchar(200)   NOT NULL COMMENT '课程名称',
  teacher_id       int(11)        NOT NULL,
  course_time      varchar(200)   DEFAULT NULL COMMENT '开课时间',
  classroom        varchar(200)   DEFAULT NULL COMMENT '开课地点',
  course_week      int(200)       DEFAULT NULL COMMENT '学时',
  course_type      varchar(20)    DEFAULT NULL COMMENT '课程类型',
  college_id       int(11)        NOT NULL COMMENT '所属院系',
  score            int(11)        NOT NULL COMMENT '学分',
  PRIMARY KEY (course_id),
  KEY college_id (college_id),
  KEY teacher_id (teacher_id),
  CONSTRAINT course_ibfk_1 FOREIGN KEY (college_id) REFERENCES college (college_id),
  CONSTRAINT course_ibfk_2 FOREIGN KEY (teacher_id) REFERENCES teacher (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO course VALUES ('1', 'C语言程序设计', '1001', '周二', '科401', '18', '必修课', '1', '3');
INSERT INTO course VALUES ('2', 'Python爬虫技巧', '1001', '周四', 'X402', '18', '必修课', '1', '3');
INSERT INTO course VALUES ('3', '数据结构', '1001', '周四', '科401', '18', '必修课', '1', '2');
INSERT INTO course VALUES ('4', 'Java程序设计', '1002', '周五', '科401', '18', '必修课', '1', '2');
INSERT INTO course VALUES ('5', '英语', '1002', '周四', 'X302', '18', '必修课', '2', '2');
INSERT INTO course VALUES ('6', '服装设计', '1003', '周一', '科401', '18', '选修课', '2', '2');

-- 3. 角色表
DROP TABLE IF EXISTS role;
CREATE TABLE role (
  role_id          int(11)        NOT NULL,
  role_name        varchar(20)    NOT NULL,
  permissions      varchar(255)   DEFAULT NULL COMMENT '权限',
  PRIMARY KEY (role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO role VALUES ('0', 'admin', null);
INSERT INTO role VALUES ('1', 'teacher', null);
INSERT INTO role VALUES ('2', 'student', null);

-- 4. 选课表
DROP TABLE IF EXISTS selectedcourse;
CREATE TABLE selectedcourse (
  course_id        int(11)        NOT NULL,
  student_id       int(11)        NOT NULL,
  mark             int(11)        DEFAULT NULL COMMENT '成绩',
  KEY course_id (course_id),
  KEY student_id (student_id),
  CONSTRAINT selectedcourse_ibfk_1 FOREIGN KEY (course_id) REFERENCES course (course_id),
  CONSTRAINT selectedcourse_ibfk_2 FOREIGN KEY (student_id) REFERENCES student (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO selectedcourse VALUES ('2', '10001', '12');
INSERT INTO selectedcourse VALUES ('1', '10001', '95');
INSERT INTO selectedcourse VALUES ('1', '10002', '66');
INSERT INTO selectedcourse VALUES ('1', '10003', null);
INSERT INTO selectedcourse VALUES ('2', '10003', '99');
INSERT INTO selectedcourse VALUES ('5', '10001', null);
INSERT INTO selectedcourse VALUES ('3', '10001', null);

-- 5. 学生表
DROP TABLE IF EXISTS student;
CREATE TABLE student (
  user_id          int(11)        NOT NULL AUTO_INCREMENT,
  user_name        varchar(200)   NOT NULL,
  gender           varchar(20)    DEFAULT NULL,
  birthday         date           DEFAULT NULL COMMENT '出生日期',
  grade            date           DEFAULT NULL COMMENT '入学时间',
  college_id       int(11)        NOT NULL COMMENT '院系id',
  PRIMARY KEY (user_id),
  KEY college_id (college_id),
  CONSTRAINT student_ibfk_1 FOREIGN KEY (college_id) REFERENCES college (college_id)
) ENGINE=InnoDB AUTO_INCREMENT=10007 DEFAULT CHARSET=utf8;

INSERT INTO student VALUES ('10001', '小黄', '男', '1996-09-02', '2015-09-02', '1');
INSERT INTO student VALUES ('10002', '小米', '女', '1995-09-14', '2015-09-02', '3');
INSERT INTO student VALUES ('10003', '小陈', '女', '1996-09-02', '2015-09-02', '2');
INSERT INTO student VALUES ('10004', '小华', '男', '1996-09-02', '2015-09-02', '2');
INSERT INTO student VALUES ('10005', '小左', '女', '1996-09-02', '2015-09-02', '2');
INSERT INTO student VALUES ('10006', '小拉', '女', '1996-09-02', '2015-09-02', '1');

-- 6. 老师表
DROP TABLE IF EXISTS teacher;
CREATE TABLE teacher (
  user_id          int(11) NOT NULL AUTO_INCREMENT,
  user_name        varchar(200) NOT NULL,
  gender           varchar(20) DEFAULT NULL,
  birthday         date NOT NULL,
  degree           varchar(20) DEFAULT NULL COMMENT '学历',
  title            varchar(255) DEFAULT NULL COMMENT '职称',
  grade            date DEFAULT NULL COMMENT '入职时间',
  college_id       int(11) NOT NULL COMMENT '院系',
  PRIMARY KEY (user_id),
  KEY college_id (college_id),
  CONSTRAINT teacher_ibfk_1 FOREIGN KEY (college_id) REFERENCES college (college_id)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8;

INSERT INTO teacher VALUES ('1001', '刘老师', '女', '1990-03-08', '硕士', '副教授', '2015-09-02', '2');
INSERT INTO teacher VALUES ('1002', '张老师', '男', '1996-09-02', '本科', '普通教师', '2015-09-02', '1');
INSERT INTO teacher VALUES ('1003', '软老师', '男', '1996-09-02', '硕士', '助教', '2017-07-07', '1');

-- 7. 用户登录表
DROP TABLE IF EXISTS userlogin;
CREATE TABLE userlogin (
  user_id          int(11) NOT NULL AUTO_INCREMENT,
  user_name        varchar(200) NOT NULL,
  password         varchar(200) NOT NULL,
  role             int(11) NOT NULL DEFAULT '2' COMMENT '角色权限',
  PRIMARY KEY (user_id),
  KEY role (role),
  CONSTRAINT userlogin_ibfk_1 FOREIGN KEY (role) REFERENCES role (role_id)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

INSERT INTO userlogin VALUES ('1', 'admin', '123', '0');
INSERT INTO userlogin VALUES ('8', '10001', '123', '2');
INSERT INTO userlogin VALUES ('9', '10002', '123', '2');
INSERT INTO userlogin VALUES ('10', '10003', '123', '2');
INSERT INTO userlogin VALUES ('11', '10005', '123', '2');
INSERT INTO userlogin VALUES ('12', '10004', '123', '2');
INSERT INTO userlogin VALUES ('13', '10006', '123', '2');
INSERT INTO userlogin VALUES ('14', '1001', '123', '1');
INSERT INTO userlogin VALUES ('15', '1002', '123', '1');
INSERT INTO userlogin VALUES ('16', '1003', '123', '1');

SET FOREIGN_KEY_CHECKS=1;
