-- 创建数据库
create database reservation;
use reservation;
-- 学生(学号, 姓名，密码，性别)
create table student
(
    `student_id` char(11)         not null primary key,
    `name`       varchar(16)      not null,
    `password`   char(32)         not null,
    `gender`     char(2)          not null,
    `is_admin`   tinyint unsigned not null,
    `slat`       varchar(16)      not null,
    constraint gender check (gender in ('男', '女')),
    constraint is_admin check ( is_admin in (0, 1) )
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
insert into student
values ('12003990101', '张三', '0f42a46c8f04df39203e298d637e9589', '男', 0, 'DoEdgl1WbZgwNL4P');
insert into student
values ('12003990102', '李四', '71543efebd17ff4641ae65df26a60275', '男', 0, '1jzsM9LIPjf0os1V');
insert into student
values ('12003990103', '王五', 'fff13395d970fbc29a4fb7b6428fe54b', '男', 0, 'X2iipUsiNd05Ki0X');
insert into student
values ('12003990104', '一一', 'c0741c024f9f1e05e2923ba842233bff', '女', 0, 'aGWa4nWt6xRJxJVU');
insert into student
values ('12003990105', '二二', 'e53f5a8ce8c0e804d827dafc18af1b75', '男', 0, 'ZV39SY5EBh5os8x2');
insert into student
values ('12003990106', '三三', '4a63b93901ff7a2de8f2f1352c53a059', '男', 0, '4lAavep3dS9eLu4p');
insert into student
values ('12003990107', '四四', '1a0df1b2da67aca5c7eb9851464cd8e2', '女', 0, '5isyrgdYkx5o56qO');
insert into student
values ('12003990108', '五五', '7a1d65a766b1593346fab62182f2b43f', '男', 0, '0DR16PRkGse9gRXt');
insert into student
values ('12003990109', '六六', '1d449d86264aac83539b1ad3c97e5a91', '男', 0, 'SZystwQIcYEJco3T');
insert into student
values ('12003990110', '七七', '5f16a4beaf248bfaa742154f16a76500', '男', 0, 'Yggo2yoNLlzy48DX');

insert into student (student_id, name, password, gender, is_admin, slat)
values ('11203990109', '老师', '637ea005fb217d65019f8345f7cc5393', '男', 1, '4NtzUEaKmACUdufC');
insert into student (student_id, name, password, gender, is_admin, slat)
values ('11203990101', '老师', 'aef6d34a0e603bd65befc767454dc720', '男', 1, '7CmbXkeOHkhlQ1tq');
insert into student (student_id, name, password, gender, is_admin, slat)
values ('11203990102', '老师', '9c74e5872e4e2fde8bd1c943983a8b48', '男', 1, 'BF1x6UgXlbCYdsQu');

-- 机房(id, 位置个数)
create table `room`
(
    `room_id`     smallint unsigned not null,
    `room_number` tinyint unsigned  not null
);
insert into room
values (101, 90);
insert into room
values (102, 180);

-- 预约记录
create table `appointment`
(
    `room_id`       smallint unsigned comment '机房号',
    `room_position` tinyint unsigned comment '机房位置',
    `student_id`    char(11) comment '学生学号',
    `class_num`     tinyint unsigned comment '第几节课',
    `appoint_time`  bigint comment '预约使用时间',
    `record_time`   bigint comment '进行预约时间',
    primary key (room_id, room_position, student_id, appoint_time, class_num)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

insert into appointment
values (101, 1, '12003990101', 1, 1588043563149, 1578043563149);
-- insert into appointment values (101, 1, '12003990101', 1, '2020-04-17', '2020-04-17 10:11:12');

insert into appointment
values (101, 1, '12003990101', 2, 1587043563149, 1578043563149);
insert into appointment
values (101, 1, '12003990101', 3, 1586043563149, 1578043563149);
insert into appointment
values (101, 1, '12003990101', 3, 1585043563149, 1578043563149);

insert into appointment
values (101, 2, '12003990102', 1, 1584043563149, 1578043563149);


insert into appointment
values (101, 5, '12003990102', 1, 1589040000000, 1588687312954);
insert into appointment
values (101, 6, '12003990103', 1, 1589040000000, 1588687312954);
insert into appointment
values (101, 7, '12003990104', 1, 1589040000000, 1588687312954);
insert into appointment
values (101, 8, '12003990105', 1, 1589040000000, 1588687312954);
insert into appointment
values (101, 9, '12003990106', 1, 1589040000000, 1588687312954);


