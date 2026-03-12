CREATE DATABASE LiderBoradJefferson;
GO

use LiderBoradJefferson;
go

--Tipos
create table UsuarioTipo (
	UsuarioTipoId INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Description nvarchar(50) not null,
	CreatedAd DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
go 

create table ModuloTipo (
	ModuloTipoId int identity(1, 1) not null PRIMARY KEY,
	Especificidad NVARCHAR(50) NOT NULL,
	Tecnologia NVARCHAR(50) NOT NULL
);
Go


CREATE TABLE Usuario (
	UsuarioId UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID() PRIMARY KEY,
	Cedula Nvarchar(10) NOT NULL,
	Nombre NVARCHAR(50) NOT NULL,
	Edad INT NOT NULL,
	NumeroTelefono NVARCHAR(10) NOT NULL,
	Correo NVARCHAR(255) NOT NULL,
	TipoId INT NOT NULL REFERENCES UsuarioTipo(UsuarioTipoId),
	CreatedAd DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE Modulo (
	ModuloId INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	ProfesorId UNIQUEIDENTIFIER NOT NULL REFERENCES Usuario(UsuarioId),
	ModuloTipoId INT NOT NULL REFERENCES ModuloTipo(ModuloTipoId),
	CreatedAd DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE Participaciones (
	ParticipacionesId INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	UsuarioId UNIQUEIDENTIFIER NOT NULL REFERENCES Usuario(UsuarioId),
	ModuloTipo INT NOT NULL REFERENCES Modulo(ModuloId),
	Puntos INT NOT NULL,
	CreatedAd DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

--DML
INSERT INTO UsuarioTipo (Description) 
VALUES
	('Profesor'),
	('Estudiante');
GO 

SELECT * FROM UsuarioTipo;


INSERT INTO ModuloTipo(Especificidad,Tecnologia)
VALUES 
('Motor de Base de Datos','SQL Server'),
('Framework','Angular'),
('Framework','.NET'),
('Entorno de ejecuccion','Node JS');
GO

SELECT * FROM ModuloTipo;
GO

DECLARE @PrimerUserId UNIQUEIDENTIFIER = NEWID();
DECLARE @SegundoUserId UNIQUEIDENTIFIER = NEWID();
DECLARE @TerceroUserId UNIQUEIDENTIFIER = NEWID();

INSERT INTO Usuario (UsuarioId, Cedula, Nombre, Edad, NumeroTelefono, Correo, TipoId)
VALUES
(@PrimerUserId, '0123456789', 'Jefferson', 30, '0192345678', 'jeffe@suc.com', 1),
(@SegundoUserId, '0153456789', 'Ernesto', 40, '0192346678', 'ernesto@suc.com', 1),
(@TerceroUserId, '0123406789', 'María', 35, '0192345378', 'maria@suc.com', 1);

DECLARE @SqlServerModuloTipo INT = (SELECT ModuloTipoId FROM ModuloTipo WHERE Tecnologia='SQL Server');
DECLARE @AngularModuloTipo INT = (SELECT ModuloTipoId FROM ModuloTipo WHERE Tecnologia = 'Angular');
DECLARE @DotNetModuloTipo INT = (SELECT ModuloTipoId FROM ModuloTipo WHERE Tecnologia = '.NET');
DECLARE @NodeJs INT = (SELECT ModuloTipoId FROM ModuloTipo WHERE Tecnologia = 'NodeJS');

INSERT INTO Modulo (ModuloTipoId, ProfesorId)
VALUES 
(@SqlServerModuloTipo,@PrimerUserId),
(@AngularModuloTipo,@PrimerUserId),
(@DotNetModuloTipo,@SegundoUserId),
(@NodeJs,@TerceroUserId);

GO

SELECT * FROM Modulo;

DELETE FROM Usuario; 

SELECT * FROM ModuloTipo WHERE Tecnologia='SQL Server';