CREATE DATABASE DiscordClone;
GO

USE DiscordClone;
GO


CREATE TABLE Roles (
	RoleId INT IDENTITY (1, 1) NOT NULL,
	Code NVARCHAR(10) NOT NULL,
	ShowName NVARCHAR(100) NOT NULL,
	CreatedAd DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO
CREATE TABLE UserStatusType (
	UserStatusTypeId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Code NVARCHAR(10) NOT NULL,
	ShowName NVARCHAR(11) NOT NULL,
	CreatedAd DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

INSERT INTO UserStatusType(Code, ShowName)
VALUES
('online', 'En linea'),
('not_disturb', 'No molestar'),
('idle', 'Ausente'),
('ghost', 'Invisible');
Go


CREATE TABLE Users (
	UserId UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	UserName NVARCHAR(32) NOT NULL,
	DisplayName Nvarchar(100) NOT NULL,
	Description NVARCHAR (255) NOT NULL,
	StatusType INT NOT NULL REFERENCES UserStatusType(UserStatusTypeId),
	StattusTime INT NULL,
	StatusContent INT NOT NULL DEFAULT ('Hi, there'),
	AvatarURL NVARCHAR(255),
	BannerURL NVARCHAR(255) NULL,
	--RoleId INT NOT NULL REFERENCES Roles (RoleId),
	CreateaAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	--CONSTRAINT FK_Roles_RoleId FOREIGN KEY (RoleId) REFERENCES Roles (RoleId)
);
GO

CREATE TABLE Collections (
	CollectionId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	Name NVARCHAR(50) NOT NULL,
	Description NVARCHAR(100) NOT NULL DEFAULT('This is my collection!'),
	CreateaAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
	DeleteAd DATETIME2
);
GO

CREATE TABLE Itmes (
	ItemId INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
	CreateaAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO 

INSERT INTO Itmes (Name)
VALUES
('Hollow Knight'),
('osu');
GO


CREATE TABLE CollectionItems(
	CollectionId UNIQUEIDENTIFIER NOT NULL REFERENCES Collections (CollectionId),
	ItemId INT NOT NULL REFERENCES Itmes (ItemId) ON DELETE CASCADE,
	CONSTRAINT PK_CollectionsItems_CollectionId_ItemId PRIMARY KEY(CollectionId, ItemId),
);
GO


INSERT INTO Collections(Name, Description)
VALUES ('mis juegos','juegos');
GO

select * from Collections where DeleteAd is null;
GO 

SELECT * FROM Itmes;


DECLARE @ItemHollowKnightId INT = (SELECT ItemId FROM Itmes WHERE ItemId=1);
DECLARE @ItemOsuId INT = (SELECT ItemId FROM Itmes WHERE ItemId=2);

CREATE INDEX IX_Items_Name ON Itmes (NAME)