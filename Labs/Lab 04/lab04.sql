start transaction;
update salary set salary = 1.1*salary where emp_no=43624; 
select * from salary where emp_no=43624;
rollback;

INSERT INTO department (dept_no,dept_name) VALUES ("d010","New Department");

update department
set dept_name = "Accounting"
where dept_no = "d010";

update department
set dept_name = "HR"
where dept_no = "d010";

CREATE TABLE menu(
     item_id VARCHAR(10) PRIMARY KEY,
     item_name VARCHAR(255) NOT NULL,
     category VARCHAR(255) NOT NULL,
     price decimal(8, 2) NOT NULL);

INSERT INTO `menu` (`item_id`, `item_name`, `category`, `price`) 
VALUES 
    ('I001', 'Chicken Fried Rice', 'Chinese', 980.00),    
    ('I002', 'Spaghetti Carbonara', 'Italian', 1400.00),
    ('I003', 'Mix Fried Noodles', 'Chinese', 900.00),
    ('I004', 'Nasi Gorenge Rice', 'Thai', 1650.00),
    ('I005', 'Seafood Mongolian Rice ', 'Mongolian', 1500.00);

start transaction;
update menu
set price = 0.90 * price
where category = "Chinese";
rollback;

start transaction;
update menu
set price = 0.95 * price
where category = "Italian";
commit;

start transaction;
update menu
set price = price + 100;
commit;

start transaction;
update menu
set price = 0.95 * price
where category = "Italian";
commit;

start transaction;
update menu
set price = price + 50
where category = "Italian";
rollback;

start transaction;
update menu
set price = price * 1.10
where category = "Mongolian";
rollback;