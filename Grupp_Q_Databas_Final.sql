CREATE DATABASE HotellIsaacDB

GO

USE HotellIsaacDB

GO

CREATE TABLE [Rum] (
  [RumID] INT IDENTITY,
  [Rumsnummer] NVARCHAR(10),
  [Rumstyp] NVARCHAR(50),
  [KostnadPerNatt] DECIMAL(10, 2),
  PRIMARY KEY ([RumID])
);

GO

CREATE TABLE [Minibar] (
	[MinibarID] INT IDENTITY,
	[RumID] INT,
	[Produkt] NVARCHAR(100),
	[Pris] Decimal(10, 2)
	PRIMARY KEY ([MinibarID])
	FOREIGN KEY ([RumID])
		REFERENCES [Rum] ([RumID])
);

GO

CREATE TABLE [Kunder] (
  [KundID] INT IDENTITY UNIQUE ([Email]),
  [Namn] NVARCHAR(100),
  [Adress] NVARCHAR(200),
  [Telefon] NVARCHAR(15),
  [Email] NVARCHAR(100),
  PRIMARY KEY ([KundID])
);

GO

CREATE TABLE [Bokningar] (
  [BokningID] INT IDENTITY,
  [KundID] INT,
  [RumID] INT,
  [Ankomsttid] DATETIME2,
  [Avresedatum] DATE,
  [SummaKostnad] DECIMAL(10, 2),
  [Betalsätt] NVARCHAR(50),
  [UteblivenAnkomst] NVARCHAR(3),
  [Kontaktperson] NVARCHAR(100),
  [SummaPersoner] INT,
  PRIMARY KEY ([BokningID]),
  CONSTRAINT [FK_Bokningar.KundID]
    FOREIGN KEY ([KundID])
      REFERENCES [Kunder]([KundID]),
  CONSTRAINT [FK_Bokningar.RumID]
    FOREIGN KEY ([RumID])
      REFERENCES [Rum]([RumID])
);

GO

CREATE TABLE [BokadeRum] (
  [BokadeRumID] INT IDENTITY,
  [BokningsID] INT,
  [RumID] INT,
  [AntalExtrabaddar] INT,
  PRIMARY KEY ([BokadeRumID]),
  CONSTRAINT [FK_BokadeRum.BokningsID]
    FOREIGN KEY ([BokningsID])
		REFERENCES [Bokningar]([BokningID]),
	FOREIGN KEY ([RumID])
		REFERENCES [Rum] ([RumID])
);

GO

CREATE TABLE [Betalkort] (
  [KortID] INT IDENTITY,
  [KundID] INT,
  [Kortnummer] NVARCHAR(20),
  [Utgångdatum] DATE,
  [CVC] INT,
  PRIMARY KEY ([KortID]),
  FOREIGN KEY ([KundID])
	REFERENCES [Kunder] ([KundID])
	
);

GO

CREATE TABLE [Önskemål] (
  [ÖnskemålID] INT IDENTITY,
  [BokningsID] INT,
  [Beskrivning] TEXT,
  PRIMARY KEY ([ÖnskemålID]),
  FOREIGN KEY ([BokningsID])
		REFERENCES [Bokningar]([BokningID])
);

GO

CREATE TABLE [Rabatter] (
  [RabattID] INT IDENTITY,
  [BokadeRumID] INT,
  [RabattTyp] NVARCHAR(100),
  [RabattBelopp] DECIMAL(10, 2),
  PRIMARY KEY ([RabattID]),
  FOREIGN KEY ([BokadeRumID])
		REFERENCES [BokadeRum]([BokadeRumID])
);

GO

CREATE TABLE [GästFeedback] (
  [FeedbackID] INT IDENTITY,
  [BokningsID] INT,
  [Kommentar] TEXT,
  [Betyg] INT,
  PRIMARY KEY ([FeedbackID]),
  FOREIGN KEY ([BokningsID])
		REFERENCES [Bokningar]([BokningID])
);

GO

CREATE TABLE [Personal] (
  [PersonalID] INT IDENTITY,
  [Namn] NVARCHAR(100),
  [Position] NVARCHAR(100),
  [KontaktInfo] NVARCHAR(200),
  PRIMARY KEY ([PersonalID])
);

GO

CREATE TABLE [Meddelanden] (
  [MeddelandenID] INT IDENTITY,
  [BokningID] INT,
  [PersonalID] INT,
  [Meddelande] TEXT,
  [DatumTid] DATETIME2,
  PRIMARY KEY ([MeddelandenID]),
  CONSTRAINT [FK_Meddelanden.BokningID]
    FOREIGN KEY ([BokningID])
      REFERENCES [Bokningar]([BokningID]),
	FOREIGN KEY ([PersonalID])
		REFERENCES [Personal]([PersonalID])
);

GO

CREATE TABLE [VistelseNotering] (
  [NoteringID] INT IDENTITY,
  [KundID] INT,
  [Notering] TEXT,
  [Betyg] INT,
  PRIMARY KEY ([NoteringID]),
  FOREIGN KEY ([KundID])
		REFERENCES [Kunder]([KundID])
);

GO

--Demodata
INSERT INTO [Rum] ([Rumsnummer], [Rumstyp], [KostnadPerNatt])
VALUES
    ('101', 'Enkelrum', 1000.00),
    ('102', 'Dubbelrum', 1500.00),
    ('103', 'Svit', 2500.00),
    ('104', 'Familjerum', 2000.00),
    ('105', 'Enkelrum', 1000.00),
    ('106', 'Dubbelrum', 1500.00),
    ('107', 'Svit', 2500.00),
    ('108', 'Familjerum', 2000.00),
    ('109', 'Enkelrum', 1000.00),
    ('110', 'Dubbelrum', 1500.00),
    ('111', 'Svit', 2500.00),
    ('112', 'Familjerum', 2000.00),
    ('113', 'Enkelrum', 1000.00),
    ('114', 'Dubbelrum', 1500.00),
    ('115', 'Svit', 2500.00),
    ('116', 'Familjerum', 2000.00),
    ('117', 'Enkelrum', 1000.00),
    ('118', 'Dubbelrum', 1500.00),
    ('119', 'Svit', 2500.00),
    ('120', 'Familjerum', 2000.00);

GO

-- Demodata
INSERT INTO [Kunder] ([Namn], [Adress], [Telefon], [Email])
VALUES
    ('Alice Andersson', 'Storgatan 123', '070-1234567', 'alice@email.com'),
    ('Bob Bengtsson', 'Lillgatan 456', '070-7654321', 'bob@email.com'),
    ('Charlie Carlsson', 'Genvägen 789', '070-9876543', 'charlie@email.com'),
    ('David Davidsson', 'Hörnet 101', '070-1112233', 'david@email.com'),
    ('Eva Eriksson', 'Baksidan 555', '070-4455667', 'eva@email.com'),
    ('Frank Fredriksson', 'Framsidan 444', '070-7788999', 'frank@email.com'),
    ('Greta Gustafsson', 'Vägen 678', '070-1122334', 'greta@email.com'),
    ('Hans Hansson', 'Övergatan 222', '070-3344556', 'hans@email.com'),
    ('Ida Isaksson', 'Undersidan 333', '070-5566778', 'ida@email.com'),
    ('Jonas Jonasson', 'Yttersidan 999', '070-8899000', 'jonas@email.com'),
    ('Klara Karlsson', 'Högersidan 333', '070-2233445', 'klara@email.com'),
    ('Lars Larsson', 'Vänstersidan 888', '070-4555666', 'lars@email.com'),
    ('Mia Månsson', 'Nedersidan 111', '070-6777888', 'mia@email.com'),
    ('Nils Nilsson', 'Uppersidan 777', '070-8999000', 'nils@email.com'),
    ('Oscar Olofsson', 'Förstasidan 444', '070-1234345', 'oscar@email.com');
	
GO

--Demodata
INSERT INTO [Bokningar] ([KundID], [RumID], [Ankomsttid], [Avresedatum], [SummaKostnad], [Betalsätt], [UteblivenAnkomst], [Kontaktperson], [SummaPersoner])
VALUES
    (1, 1, '2023-12-01 14:00:00', '2023-12-05', 4000.00, 'Kreditkort', 'Nej', 'Receptionen', 1),
    (2, 2, '2023-12-02 12:00:00', '2023-12-06', 6000.00, 'Kontant', 'Ja', 'Bob Bengtsson', 2),
    (3, 3, '2023-12-03 15:00:00', '2023-12-07', 10000.00, 'Kreditkort', 'Nej', 'Receptionen', 1),
    (4, 4, '2023-12-04 10:00:00', '2023-12-08', 8000.00, 'Kreditkort', 'Nej', 'Receptionen', 3),
    (5, 5, '2023-12-05 14:00:00', '2023-12-09', 4000.00, 'Kontant', 'Ja', 'Eva Eriksson', 1),
    (6, 6, '2023-12-06 12:00:00', '2023-12-10', 6000.00, 'Kreditkort', 'Nej', 'Receptionen', 2),
    (7, 7, '2023-12-07 15:00:00', '2023-12-11', 10000.00, 'Kontant', 'Ja', 'Greta Gustafsson', 2),
    (8, 8, '2023-12-08 10:00:00', '2023-12-12', 8000.00, 'Kreditkort', 'Nej', 'Receptionen', 3),
    (9, 9, '2023-12-09 14:00:00', '2023-12-13', 4000.00, 'Kontant', 'Ja', 'Hans Hansson', 1),
    (10, 10, '2023-12-10 12:00:00', '2023-12-14', 6000.00, 'Kreditkort', 'Nej', 'Receptionen', 2),
    (11, 11, '2023-12-11 15:00:00', '2023-12-15', 10000.00, 'Kontant', 'Ja', 'Klara Karlsson', 2),
    (12, 12, '2023-12-12 10:00:00', '2023-12-16', 8000.00, 'Kreditkort', 'Nej', 'Receptionen', 3),
    (13, 13, '2023-12-13 14:00:00', '2023-12-17', 4000.00, 'Kontant', 'Ja', 'Mia Månsson', 1),
    (14, 14, '2023-12-14 12:00:00', '2023-12-18', 6000.00, 'Kreditkort', 'Nej', 'Receptionen', 2),
    (15, 15, '2023-12-15 15:00:00', '2023-12-19', 10000.00, 'Kontant', 'Ja', 'Nils Nilsson', 2);
	
GO

--Demodata
INSERT INTO [BokadeRum] ([BokningsID], [RumID], [AntalExtrabaddar])
VALUES
    (1, 1, 0),
    (2, 2, 1),
    (3, 3, 0),
    (4, 4, 2),
    (5, 5, 0),
    (6, 6, 1),
    (7, 7, 2),
    (8, 8, 0),
    (9, 9, 1),
    (10, 10, 2),
    (11, 11, 0),
    (12, 12, 1),
    (13, 13, 0),
    (14, 14, 2),
    (15, 15, 0);

GO

--Demodata
INSERT INTO [GästFeedback] ([BokningsID], [Kommentar], [Betyg])
VALUES
    (1, 'Mycket trevligt rum!', 5),
    (2, 'Bra service och bekvämt rum.', 4),
    (3, 'Fantastisk svit med vacker utsikt!', 5),
    (4, 'Rymligt familjerum, perfekt för barnfamiljer.', 4),
    (5, 'Enkelrummet var mysigt och rent.', 3),
    (6, 'Dubbelrummet hade bra faciliteter.', 4),
    (7, 'Sviten var lyxig och bekväm.', 5),
    (8, 'Familjerummet hade gott om plats för alla.', 4),
    (9, 'Enkelrummet var rent och tyst.', 3),
    (10, 'Dubbelrummet var bekvämt med fin utsikt.', 4),
    (11, 'Sviten var elegant och rymlig.', 5),
    (12, 'Familjerummet hade alla bekvämligheter.', 4),
    (13, 'Mycket trevligt enkelrum med fin inredning.', 3),
    (14, 'Bra service och bekvämt dubbelrum.', 4),
    (15, 'Sviten hade fantastisk utsikt och bekväm säng.', 5);
	
GO

--Demodata
INSERT INTO [Personal] ([Namn], [Position], [KontaktInfo])
VALUES
    ('Anna Andersson', 'Receptionist', 'anna@email.com'),
    ('Bengt Bengtsson', 'Städare', 'bengt@email.com'),
    ('Caroline Carlsson', 'Kock', 'caroline@email.com'),
    ('David Davidsson', 'Servitör', 'david@email.com'),
    ('Eva Eriksson', 'Portier', 'eva@email.com')
	
GO

--Demodata
INSERT INTO [Meddelanden] ([BokningID], [PersonalID], [Meddelande], [DatumTid])
VALUES
    (1, 1, 'Välkommen till Hotel Isaac! Hör av dig om du behöver något.', '2023-12-01 14:30:00'),
    (2, 2, 'Städning av rummet är schemalagd för imorgon.', '2023-12-02 13:00:00'),
    (3, 3, 'Vi hoppas du njuter av din vistelse i vår svit!', '2023-12-03 16:45:00')
	
GO

--Demodata
INSERT INTO [VistelseNotering] ([KundID], [Notering], [Betyg])
VALUES
    (1, 'Mycket trevlig vistelse hittills.', 4),
    (2, 'Bra hotell med vänlig personal.', 3),
    (3, 'Fantastisk utsikt från sviten!', 5),
	(4, 'Bra rum och bekvämligheter.', 4),
    (5, 'Enkel och smidig incheckning.', 5),
    (6, 'Bra valuta för pengarna.', 4),
    (7, 'Mycket trevlig personal.', 5),
    (8, 'Familjerummet passade perfekt för oss.', 4),
    (9, 'Bekvämt och rent.', 5),
    (10, 'Fin utsikt från fönstret.', 4),
    (11, 'Sviten var över förväntan!', 5),
    (12, 'Bra faciliteter och service.', 4),
    (13, 'Mysigt rum och trevlig atmosfär.', 5),
    (14, 'Rent och snyggt.', 4),
    (15, 'Välkomnande personal.', 5)
	
GO

--Demodata
INSERT INTO [Minibar] ([RumID], [Produkt], [Pris])
VALUES
    (1, 'Choklad', 20.00),
    (2, 'Soda', 15.00),
    (3, 'Champagne', 100.00),
    (4, 'Läsk', 10.00),
    (5, 'Nötter', 25.00),
    (6, 'Juice', 12.00),
    (7, 'Vin', 30.00),
    (8, 'Snacks', 18.00),
    (9, 'Kex', 8.00),
    (10, 'Vatten', 5.00),
    (11, 'Fruktkorg', 25.00),
    (12, 'Godis', 15.00),
    (13, 'Kaffe', 8.00),
    (14, 'Te', 7.00),
    (15, 'Whisky', 50.00)
	
GO

--Demodata
INSERT INTO [Betalkort] ([KundID], [Kortnummer], [Utgångdatum], [CVC])
VALUES
    (1, '1234567890123456', '2025-12-31', 123),
    (3, '3456789012345678', '2023-10-31', 789),
    (4, '4567890123456789', '2022-09-30', 101),
    (6, '6789012345678901', '2020-07-31', 223),
    (8, '8901234567890123', '2024-05-31', 445),
    (10, '0123456789012345', '2022-03-31', 667),
    (12, '2345098765432101', '2020-01-31', 889),
    (14, '4560987654321013', '2024-11-30', 101);
	
GO

--Demodata
INSERT INTO [Önskemål] ([BokningsID], [Beskrivning])
VALUES
    (1, 'Extra kudde och filtar'),
    (2, 'Utsikt mot havet'),
    (3, 'Rökfritt rum'),
    (4, 'Tillgänglighetsanpassat badrum'),
    (5, 'Barnsäng'),
    (6, 'Högt våningsplan'),
    (7, 'Fruktkorg vid ankomst'),
    (8, 'Allergianpassat rum'),
    (9, 'Sen incheckning'),
    (10, 'Tidig utcheckning'),
    (11, 'Blommor i rummet'),
    (12, 'Extra handdukar'),
    (13, 'Överraskning för födelsedag'),
    (14, 'Veganfrukost'),
    (15, 'Rum med jacuzzi');
	
GO

--Demodata
INSERT INTO [Rabatter] ([BokadeRumID], [RabattTyp], [RabattBelopp])
VALUES
    (1, 'Rabatt1', 50.00),
    (4, 'Rabatt1', 50.00),
    (5, 'Rabatt2', 75.00),
    (7, 'Rabatt1', 50.00),
    (8, 'Rabatt2', 75.00),
    (11, 'Rabatt2', 75.00)
	
GO

--Trigger för att lägga till rabatt på en bokning.
CREATE OR ALTER TRIGGER UppdateraTotaltSummaMedRabatt
	ON Rabatter
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Uppdatera SummaKostnad i Bokningar baserat på rabatten
    UPDATE Bokningar
    SET SummaKostnad = SummaKostnad - i.RabattBelopp
    FROM inserted i
    INNER JOIN BokadeRum br ON i.BokadeRumID = br.BokadeRumID
    INNER JOIN Bokningar b ON br.BokningsID = b.BokningID
    WHERE b.BokningID = br.BokningsID
    AND NOT EXISTS (
        -- Kontrollerar att det inte finns någon annan rabatt för samma BokadeRumID i Rabatter
        SELECT 1
        FROM Rabatter
        WHERE BokadeRumID = i.BokadeRumID
        AND RabattID != i.RabattID
    );
END;

GO

--Test för trigger för att se rabatt.
INSERT INTO Rabatter (BokaderumID, Rabatttyp, rabattbelopp)
VALUES ( 3, 'Välkomstrabatt', 1000)

GO

--Procedure som uppdaterar kontaktperson
CREATE PROCEDURE usp_Updaterakontaktperson
    @BokningsID int,
    @NyKontakt NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Bokningar
    SET Kontaktperson = @NyKontakt
    WHERE BokningID = @BokningsID;
END;

GO

--Test för att se procedur usp_Updaterakontaktperson
EXEC usp_Updaterakontaktperson @BokningsID = 1, @NyKontakt = 'Claes Engelin';

GO

--Skapar en procedure som kollar upp alla bokningar
CREATE OR ALTER PROCEDURE usp_KollaUppbokning
AS
BEGIN
  SELECT K.*, B.*
  FROM Kunder K
  INNER JOIN Bokningar B ON K.KundID = B.KundID;
END;

GO

--Test för att se procedur usp_KollaUppBokning
EXEC usp_KollaUppbokning

GO

--Procedur som skapar AddCustomer som används i nästa procedur
CREATE OR ALTER PROCEDURE AddCustomer
    @Namn NVARCHAR(100),
    @Adress NVARCHAR(200),
    @Telefon NVARCHAR(15),
    @Email NVARCHAR(100),
    @KundID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [Kunder] ([Namn], [Adress], [Telefon], [Email])
    VALUES (@Namn, @Adress, @Telefon, @Email);

    -- Returnerar det genererade KundID
    SET @KundID = SCOPE_IDENTITY();
END;

GO

--Procedur som låter användaren lägga till ny bokning. (Innehåller transaktion)
CREATE OR ALTER PROCEDURE usp_AddCustomerBookingPayment
    @Namn NVARCHAR(100),
    @Adress NVARCHAR(200),
    @Telefon NVARCHAR(15),
    @Email NVARCHAR(100),
    @Rumsnummer NVARCHAR(10),
    @Ankomsttid DATETIME2,
    @Avresedatum DATE,
    @SummaKostnad DECIMAL(10, 2),
    @Betalsatt NVARCHAR(50),
    @UteblivenAnkomst NVARCHAR(3),
    @Kontaktperson NVARCHAR(100),
    @SummaPersoner INT,
    @Kortnummer NVARCHAR(20),
    @Utgangdatum DATE,
    @CVC INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Variabel för att lagra KundID
    DECLARE @KundID INT

    -- Variabel för att lagra BokningID
    DECLARE @BokningID INT

    -- Starta transaktion
    BEGIN TRY
        SET XACT_ABORT ON; -- Avbryt hela transaktionen om det uppstår ett fel
        BEGIN TRANSACTION;

        -- Kolla om kunden redan finns och lägg till kunden om den inte finns
        EXEC AddCustomer @Namn, @Adress, @Telefon, @Email, @KundID OUTPUT

        -- Hämta RumID baserat på det valda rumsnumret
        DECLARE @RumID INT
        SELECT @RumID = RumID FROM Rum WHERE Rumsnummer = @Rumsnummer

        -- Kolla om rummet redan är bokat för den angivna perioden
        IF EXISTS (
            SELECT 1
            FROM Bokningar b
            WHERE b.RumID = @RumID
              AND ((@Ankomsttid >= b.Ankomsttid AND @Ankomsttid < b.Avresedatum)
                    OR (@Avresedatum > b.Ankomsttid AND @Avresedatum <= b.Avresedatum)
                    OR (@Ankomsttid <= b.Ankomsttid AND @Avresedatum >= b.Avresedatum))
        )
        BEGIN
            -- Om rummet redan är bokat, gör en rollback och kasta ett felmeddelande
            THROW 51000, 'Rummet är redan bokat för den angivna perioden.', 1;
        END

        -- Lägg till bokningsinformation
        INSERT INTO Bokningar (KundID, RumID, Ankomsttid, Avresedatum, SummaKostnad, Betalsätt, UteblivenAnkomst, Kontaktperson, SummaPersoner)
        VALUES (@KundID, @RumID, @Ankomsttid, @Avresedatum, @SummaKostnad, @Betalsatt, @UteblivenAnkomst, @Kontaktperson, @SummaPersoner)

        -- Hämta det genererade BokningID
        SET @BokningID = SCOPE_IDENTITY()

        -- Lägg till betalningsinformation
        INSERT INTO Betalkort (KundID, Kortnummer, Utgångdatum, CVC)
        VALUES (@KundID, @Kortnummer, @Utgangdatum, @CVC)

        -- Om allt går bra, committa transaktionen
        COMMIT;

        PRINT 'Kund, bokning och betalning tillagda.';
    END TRY
    BEGIN CATCH
        -- Om något går fel, gör en rollback
        IF @@TRANCOUNT > 0
            ROLLBACK;

        -- Skicka felmeddelandet tillbaka till klienten eller logga det
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        PRINT 'Error in usp_AddCustomerBookingPayment: ' + @ErrorMessage;
    END CATCH
END;

GO

--Test för proceduren usp_AddCustomerBookingPayment
EXEC usp_AddCustomerBookingPayment
    @Namn = 'Claes Engelin',
    @Adress = 'Göteborgarnas väg 1',
    @Telefon = '0735079888',
    @Email = 'Claes.engelin@zocom.co',
    @Rumsnummer = N'110',
    @Ankomsttid = '2023-12-01T12:00:00', 
    @Avresedatum = '2023-12-05',
    @SummaKostnad = 2500.00,
    @Betalsatt = 'Kreditkort',
    @UteblivenAnkomst = 'Nej',
    @Kontaktperson = 'Claes',
    @SummaPersoner = 3,
    @Kortnummer = '1234567890456789',
    @Utgangdatum = '2026-12-01',
    @CVC = 456;

