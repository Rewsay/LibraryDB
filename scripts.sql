CREATE TABLE Readers (
    ReaderId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    RegistrationDate DATETIME NOT NULL DEFAULT GETDATE(),
    IsActive BIT NOT NULL DEFAULT 1,
    ReaderGuid UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID()
);

CREATE TABLE Authors (
    AuthorId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    BirthDate DATE NULL,
    Rating DECIMAL(3,2) NULL CHECK (Rating >= 0 AND Rating <= 5)
);

CREATE TABLE Books (
    BookId INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    AuthorId INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    IsAvailable BIT NOT NULL DEFAULT 1,
    PublicationDate DATE NULL,
    CONSTRAINT FK_Books_Author FOREIGN KEY (AuthorId) REFERENCES Authors(AuthorId) ON DELETE CASCADE
);

CREATE TABLE Genres (
    GenreId INT IDENTITY(1,1) PRIMARY KEY,
    GenreName NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE BookGenres (
    BookId INT NOT NULL,
    GenreId INT NOT NULL,
    CONSTRAINT PK_BookGenres PRIMARY KEY (BookId, GenreId),
    CONSTRAINT FK_BookGenres_Book FOREIGN KEY (BookId) REFERENCES Books(BookId),
    CONSTRAINT FK_BookGenres_Genre FOREIGN KEY (GenreId) REFERENCES Genres(GenreId)
);

CREATE TABLE Loans (
    LoanId INT IDENTITY(1,1) PRIMARY KEY,
    BookId INT NOT NULL,
    ReaderId INT NOT NULL,
    LoanDate DATETIME NOT NULL DEFAULT GETDATE(),
    DueDate DATETIME NOT NULL,
    ReturnDate DATETIME NULL,
    CONSTRAINT FK_Loans_Book FOREIGN KEY (BookId) REFERENCES Books(BookId),
    CONSTRAINT FK_Loans_Reader FOREIGN KEY (ReaderId) REFERENCES Readers(ReaderId)
);
CREATE UNIQUE INDEX UQ_Readers_Email ON Readers(Email);
