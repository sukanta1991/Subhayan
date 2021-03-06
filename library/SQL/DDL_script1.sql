create table [bookLibrary].[dbo].Author(
ID int IDENTITY(1,1) PRIMARY KEY,
Name varchar(50) NOT NULL,
[Desc] varchar (200)
)

create table [bookLibrary].[dbo].Category(
ID int IDENTITY(1,1) PRIMARY KEY,
[Type] varchar(30) NOT NULL UNIQUE,
[Desc] varchar (200)
)

create table [bookLibrary].[dbo].Publication(
ID int IDENTITY(1,1) PRIMARY KEY,
Name varchar(30) NOT NULL UNIQUE,
Details varchar (200)
)

create table [bookLibrary].[dbo].Roles(
ID int IDENTITY(1,1) PRIMARY KEY,
[Type] varchar(20) NOT NULL UNIQUE,
[Desc] varchar (100)
)

create table [bookLibrary].[dbo].Country(
ID int IDENTITY(1,1) PRIMARY KEY,
Name varchar(50) NOT NULL UNIQUE
)
create table [bookLibrary].[dbo].Location(
ID int IDENTITY(1,1) PRIMARY KEY,
CID INT  FOREIGN KEY references Country(ID),
Name varchar(50) NOT NULL
)

create table [bookLibrary].[dbo].Book(
ISBN BIGint PRIMARY KEY,
AuthorID INT  FOREIGN KEY references Author(ID),
CategoryID INT  FOREIGN KEY references Category(ID),
PublicationID INT  FOREIGN KEY references Publication(ID),
Name varchar(50) NOT NULL,
PublishDate Date NOT NULL,
Edition INT,
Price FLOAT NOT NULL

)

create table [bookLibrary].[dbo].EBook(
ISBN bigint FOREIGN KEY references Book(ISBN) PRIMARY KEY,
[Path] varchar(50) NOT NULL,
Format varchar(50) NOT NULL
)

create table [bookLibrary].[dbo].Address(
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


create table [bookLibrary].[dbo].Library(
ID int IDENTITY(1,1) PRIMARY KEY,
Name varchar(50) NOT NULL,
AddressID INT  FOREIGN KEY references Address(ID),
OwnerName varchar(50)NOT NULL
)

create table [bookLibrary].[dbo].LibraryBook(
ID int IDENTITY(1,1) PRIMARY KEY,
ISBN bigINT FOREIGN KEY references Book(ISBN),
LIbraryID INT FOREIGN KEY references Library(ID),
[Count] INT NOT NULL,
InStock Bit NOT NULL,
AvailableFrom Date NOT NULL,
)

create table [bookLibrary].[dbo].Users(
ID int IDENTITY(1,1) PRIMARY KEY,
Fname varchar(20) NOT NULL,
Mname varchar(15),
Lname varchar(20) NOT NULL,
AddressID INT  FOREIGN KEY references Address(ID),
HasLibrary bit NOT NULL,
LIbraryID INT FOREIGN KEY references Library(ID),

)

create table [bookLibrary].[dbo].Creds(
ID int FOREIGN KEY references Users(ID) PRIMARY KEY,
UName varchar(20) NOT NULL,
[Password] varchar(20) NOT NULL
)

create table [bookLibrary].[dbo].UserRole(
ID int FOREIGN KEY references Users(ID) PRIMARY KEY,
UName varchar(20) NOT NULL,
RollID INT FOREIGN KEY references Roles(ID)
)

CREATE TABlE [bookLibrary].[dbo].Transactions(
ID int identity(1,1) Primary KEY,
UserID int Foreign KEY References Users(ID),
LbID int FOREIGN KEY REFERENCES Library(ID),
[TYPE] Varchar(20) NOT NULL,
TDate DATE NOT NULL
)


CREATE TABLE [bookLibrary].[dbo].Dues(
ID INT IDENTITY(1,1) PRIMARY KEY,
UserID INT FOREIGN KEY REFERENCES Users(ID),
ISBN BIGINT FOREIGN KEY REFERENCES Book(ISBN),
BorrowTran INT FOREIGN KEY REFERENCES Transactions(ID),
ReturnTran INT FOREIGN KEY REFERENCES Transactions(ID),
DueDate DATE NOT NULL,
HasReturned Bit NOT NULL,
Condition Varchar(15)
)

create table [bookLibrary].[dbo]Price(
ID int IDENTITY(1,1) PRIMARY KEY,
[Amount] Float NOT NULL,
[Duration] Int NOT NULL,
[Currency] VARCHAR NOT NULL,
[LocationId] Int FOREIGN KEY references Location(ID),
[CountryId] Int FOREIGN KEY references Country(ID)
)

create table  [bookLibrary].[dbo].Offer(
ID int IDENTITY(1,1) PRIMARY KEY,
[MTypeID] Int FOREIGN KEY references MembershipType(ID),
[PriceID] Int FOREIGN KEY references Price(ID),
[DESC] VARCHAR(150),
[StartDate] DateTime NOT NULL,
[EndTime] DateTime NOT NULL
)


create table  [bookLibrary].[dbo].Coupon(
ID int IDENTITY(1,1) PRIMARY KEY,
[Code] VARCHAR(20) NOT NULL UNIQUE,
[MTypeID] Int FOREIGN KEY references MembershipType(ID),
[PriceID] Int FOREIGN KEY references Price(ID),
[DESC] VARCHAR(150),
[StartDate] DateTime NOT NULL,
[EndTime] DateTime NOT NULL,
[IsBulk] Bit,
[IsValid] Bit
)

create table  [bookLibrary].[dbo].Membership(
ID int IDENTITY(1,1) PRIMARY KEY,
[UserID] Int FOREIGN KEY references Users(ID),
[MTypeID] Int FOREIGN KEY references MembershipType(ID),
[StartDate] DateTime NOT NULL,
[EndTime] DateTime NOT NULL,
[IsRenewed] Bit NOT NULL
)


create table  [bookLibrary].[dbo].MembershipType(
ID int IDENTITY(1,1) PRIMARY KEY,
[Name] VARCHAR(20) NOT NULL UNIQUE,
[PriceID] Int FOREIGN KEY references Price(ID),
[DESC] VARCHAR(100)
)

create table  [bookLibrary].[dbo].Fine(
ID int IDENTITY(1,1) PRIMARY KEY,
[UserID] Int FOREIGN KEY references Users(ID),
[DueID] Int FOREIGN KEY references Dues(ID),
[Amount] FLOAT NOT NULL,
[IsPaid] Bit NOT NULL,
[DueOn] Date NOT NULL,
[DESC] VARCHAR(150)
)

create table  [bookLibrary].[dbo].ServiceRequest(
ID int IDENTITY(1,1) PRIMARY KEY,
[UserID] Int FOREIGN KEY references Users(ID),
[LBID] Int FOREIGN KEY references LibraryBook(ID),
[Status] VARCHAR(25) NOT NULL,
[Agent] VARCHAR(50) NOT NULL,
[TranID] Int FOREIGN KEY references Transactions(ID),
)


create table  [bookLibrary].[dbo].Payment(
ID int IDENTITY(1,1) PRIMARY KEY,
[FineID] Int FOREIGN KEY references Fine(ID),
[PriceID] Int FOREIGN KEY references Price(ID),
[TransID] Int FOREIGN KEY references Transactions(ID),
[PayeeName] VARCHAR(50) NOT NULL UNIQUE,
[Status] VARCHAR(20) NOT NULL,
[PTime] DateTime
)
