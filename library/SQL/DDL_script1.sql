create table Author(
ID int IDENTITY(1,1) PRIMARY KEY,
Name varchar(50) NOT NULL,
[Desc] varchar (200)
)

create table Category(
ID int IDENTITY(1,1) PRIMARY KEY,
[Type] varchar(30) NOT NULL UNIQUE,
[Desc] varchar (200)
)

create table Publication(
ID int IDENTITY(1,1) PRIMARY KEY,
Name varchar(30) NOT NULL UNIQUE,
Details varchar (200)
)

create table Roles(
ID int IDENTITY(1,1) PRIMARY KEY,
[Type] varchar(20) NOT NULL UNIQUE,
[Desc] varchar (100)
)

create table Country(
ID int IDENTITY(1,1) PRIMARY KEY,
Name varchar(50) NOT NULL UNIQUE
)
create table Location(
ID int IDENTITY(1,1) PRIMARY KEY,
CID INT  FOREIGN KEY references Country(ID),
Name varchar(50) NOT NULL
)

create table Book(
ISBN BIGint PRIMARY KEY,
AuthorID INT  FOREIGN KEY references Author(ID),
CategoryID INT  FOREIGN KEY references Category(ID),
PublicationID INT  FOREIGN KEY references Publication(ID),
Name varchar(50) NOT NULL,
PublishDate Date NOT NULL,
Edition INT,
Price FLOAT NOT NULL

)

create table EBook(
ISBN bigint FOREIGN KEY references Book(ISBN) PRIMARY KEY,
[Path] varchar(50) NOT NULL,
Format varchar(50) NOT NULL
)

create table Address(
ID int IDENTITY(1,1) PRIMARY KEY,
CountryID INT  FOREIGN KEY references Country(ID),
LocationID INT  FOREIGN KEY references Location(ID),
Latitude FLOAT NOT NULL,
Longitude FLOAT NOT NULL,
Street varchar(50) NOT NULL,
Locality varchar(50) NOT NULL,
City varchar(20) NOT NULL,
[State] varchar(20) NOT NULL,
Country varchar(20) NOT NULL,
Zipcode INT NOT NULL,
PhNo BIGINT NOT NULL,
AltNo BIGINT NOT NULL
)


create table Library(
ID int IDENTITY(1,1) PRIMARY KEY,
Name varchar(50) NOT NULL,
AddressID INT  FOREIGN KEY references Address(ID),
OwnerName varchar(50)NOT NULL
)

create table LibraryBook(
ID int IDENTITY(1,1) PRIMARY KEY,
ISBN bigINT FOREIGN KEY references Book(ISBN),
LIbraryID INT FOREIGN KEY references Library(ID),
[Count] INT NOT NULL,
InStock Bit NOT NULL,
AvailableFrom Date NOT NULL,
)

create table Users(
ID int IDENTITY(1,1) PRIMARY KEY,
Fname varchar(20) NOT NULL,
Mname varchar(15),
Lname varchar(20) NOT NULL,
AddressID INT  FOREIGN KEY references Address(ID),
HasLibrary bit NOT NULL,
LIbraryID INT FOREIGN KEY references Library(ID),

)

create table Creds(
ID int FOREIGN KEY references Users(ID) PRIMARY KEY,
UName varchar(20) NOT NULL,
[Password] varchar(20) NOT NULL
)

create table UserRole(
ID int FOREIGN KEY references Users(ID) PRIMARY KEY,
UName varchar(20) NOT NULL,
RollID INT FOREIGN KEY references Roles(ID)
)

CREATE TABlE Transactions(
ID int identity(1,1) Primary KEY,
UserID int Foreign KEY References Users(ID),
LbID int FOREIGN KEY REFERENCES Library(ID),
[TYPE] Varchar(20) NOT NULL,
TDate DATE NOT NULL
)


CREATE TABLE Dues(
ID INT IDENTITY(1,1) PRIMARY KEY,
UserID INT FOREIGN KEY REFERENCES Users(ID),
ISBN BIGINT FOREIGN KEY REFERENCES Book(ISBN),
BorrowTran INT FOREIGN KEY REFERENCES Transactions(ID),
ReturnTran INT FOREIGN KEY REFERENCES Transactions(ID),
DueDate DATE NOT NULL,
HasReturned Bit NOT NULL,
Condition Varchar(15)
)
