-- create_database.sql
IF DB_ID('TourismDB') IS NOT NULL
    DROP DATABASE TourismDB;
GO
CREATE DATABASE TourismDB;
GO
USE TourismDB;
GO

CREATE TABLE Countries (
    CountryID   INT IDENTITY(1,1) PRIMARY KEY,
    CountryName NVARCHAR(50) NOT NULL,
    Climate     NVARCHAR(30)
);

CREATE TABLE TourTypes (
    TypeID      INT IDENTITY(1,1) PRIMARY KEY,
    TypeName    NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200)
);

CREATE TABLE Tours (
    TourID      INT IDENTITY(1,1) PRIMARY KEY,
    Title       NVARCHAR(200) NOT NULL,
    CountryID   INT NOT NULL
        CONSTRAINT FK_Tours_Countries REFERENCES Countries(CountryID),
    TypeID      INT NOT NULL
        CONSTRAINT FK_Tours_TourTypes REFERENCES TourTypes(TypeID),
    StartDate   DATE    NOT NULL,
    EndDate     DATE    NOT NULL,
    Price       DECIMAL(10,2) NOT NULL
);

INSERT INTO Countries (CountryName, Climate) VALUES
  ('Турция', 'умеренный'),
  ('Италия', 'умеренный'),
  ('Таиланд', 'тропический');

INSERT INTO TourTypes (TypeName, Description) VALUES
  ('Пляжный отдых',     'Отдых на море'),
  ('Экскурсионный',     'Обзор достопримечательностей'),
  ('Горнолыжный',       'Отдых в горах');

INSERT INTO Tours (Title, CountryID, TypeID, StartDate, EndDate, Price) VALUES
  ('Анталия: Побережье Средиземного моря', 1, 1, '2024-06-15', '2024-06-22', 1200.00),
  ('Экскурсия по Риму и Флоренции',         2, 2, '2024-07-10', '2024-07-17', 1800.00),
  ('Альпы: Зимние каникулы',               3, 3, '2024-12-20', '2024-12-27', 2100.00);
