-- Create database
CREATE DATABASE IF NOT EXISTS newelibrary;
USE newelibrary;

-- Create books table
CREATE TABLE IF NOT EXISTS books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) NOT NULL,
    available BOOLEAN DEFAULT TRUE,
    cover_image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_isbn (isbn),
    INDEX idx_title (title),
    INDEX idx_author (author)
);

-- Create borrowers table
CREATE TABLE IF NOT EXISTS borrowers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_email (email),
    INDEX idx_name (name)
);

-- Create borrowing_records table
CREATE TABLE IF NOT EXISTS borrowing_records (
    id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    borrower_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    due_date DATE NOT NULL,
    status ENUM('BORROWED', 'RETURNED', 'OVERDUE') DEFAULT 'BORROWED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE RESTRICT,
    FOREIGN KEY (borrower_id) REFERENCES borrowers(id) ON DELETE RESTRICT,
    INDEX idx_borrower (borrower_id),
    INDEX idx_book (book_id),
    INDEX idx_status (status)
);

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    password_salt VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'LIBRARIAN', 'USER') NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    last_login TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_email (email),
    INDEX idx_username (username),
    INDEX idx_role (role)
);

-- Insert sample data for books
INSERT INTO books (title, author, isbn, available, cover_image) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', TRUE, 'gatsby.jpg'),
('To Kill a Mockingbird', 'Harper Lee', '9780446310789', TRUE, 'mockingbird.jpg'),
('1984', 'George Orwell', '9780451524935', TRUE, '1984.jpg'),
('Pride and Prejudice', 'Jane Austen', '9780141439518', TRUE, 'pride.jpg'),
('The Catcher in the Rye', 'J.D. Salinger', '9780316769488', TRUE, 'catcher.jpg');

-- Insert sample data for borrowers
INSERT INTO borrowers (name, email, phone) VALUES
('John Doe', 'john.doe@email.com', '123-456-7890'),
('Jane Smith', 'jane.smith@email.com', '234-567-8901'),
('Bob Johnson', 'bob.johnson@email.com', '345-678-9012'),
('Alice Brown', 'alice.brown@email.com', '456-789-0123'),
('Charlie Wilson', 'charlie.wilson@email.com', '567-890-1234');

-- Insert sample data for users (with hashed passwords)
INSERT INTO users (username, password, password_salt, email, role) VALUES
('admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'salt1', 'admin@elibrary.com', 'ADMIN'),
('librarian', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'salt2', 'librarian@elibrary.com', 'LIBRARIAN'),
('user1', '04f8996da763b7a969b1028ee3007569eaf3a635486ddab211d512c85b9df8fb', 'salt3', 'user1@elibrary.com', 'USER');

-- Insert sample borrowing records
INSERT INTO borrowing_records (book_id, borrower_id, borrow_date, due_date, return_date, status) VALUES
(1, 1, '2024-01-01', '2024-01-15', '2024-01-15', 'RETURNED'),
(2, 2, '2024-01-02', '2024-01-16', NULL, 'BORROWED'),
(3, 3, '2024-01-03', '2024-01-17', '2024-01-17', 'RETURNED'),
(4, 4, '2024-01-04', '2024-01-18', NULL, 'OVERDUE'),
(5, 5, '2024-01-05', '2024-01-19', '2024-01-19', 'RETURNED'); 