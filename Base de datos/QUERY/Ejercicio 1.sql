--Crea una tabla que se llame Tags y la tablka intermedia
--que se llame PostTgas. Un Post puede tener muchos Tags,
--un Tags puede estar en muchos Pots. Incluyan constrains correctos

USE TalentInsights;

Create table Tags (
	TagsId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ShowName NVARCHAR(50) NOT NULL,
	CreatedAd DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

INSERT INTO Tags (ShowName) 
VALUES
('#marketingdigital'),
('#digital'),
('#Tecnología'),
('#Programación'),
('#BasesDeDatos');
GO 

CREATE TABLE PostTags(
	PostId UNIQUEIDENTIFIER NOT NULL REFERENCES  Posts(Id),
	TagsId INT NOT NULL REFERENCES Tags (TagsId),
	CONSTRAINT PK_PostsTagsId_PostsId_TgasId PRIMARY KEY(PostId, TagsId),
);
GO

select * from tags;