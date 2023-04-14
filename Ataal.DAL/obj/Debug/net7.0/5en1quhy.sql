IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(450) NOT NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [AspNetUsers] (
    [Id] nvarchar(450) NOT NULL,
    [UserName] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [Email] nvarchar(256) NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [PasswordHash] nvarchar(max) NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [LockoutEnabled] bit NOT NULL,
    [AccessFailedCount] int NOT NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [KeyWords] (
    [KeyWord_ID] int NOT NULL IDENTITY,
    [KeyWord_Name] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_KeyWords] PRIMARY KEY ([KeyWord_ID])
);
GO

CREATE TABLE [Sections] (
    [Section_ID] int NOT NULL IDENTITY,
    [Section_Name] nvarchar(20) NOT NULL,
    [Description] nvarchar(200) NOT NULL,
    [Photo] varbinary(max) NULL,
    CONSTRAINT [PK_Sections] PRIMARY KEY ([Section_ID])
);
GO

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [RoleId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Admin] (
    [Id] int NOT NULL IDENTITY,
    [AppUserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_Admin] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Admin_AspNetUsers_AppUserId] FOREIGN KEY ([AppUserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [UserId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(450) NOT NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserTokens] (
    [UserId] nvarchar(450) NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Customer] (
    [Id] int NOT NULL IDENTITY,
    [AppUserId] nvarchar(450) NOT NULL,
    [Phone] nvarchar(max) NULL,
    [Photo] varbinary(max) NULL,
    [Address] nvarchar(100) NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Customer_AspNetUsers_AppUserId] FOREIGN KEY ([AppUserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Technical] (
    [Id] int NOT NULL IDENTITY,
    [Phone] nvarchar(max) NOT NULL,
    [AppUserId] nvarchar(450) NOT NULL,
    [Photo] varbinary(max) NULL,
    [Rate] int NOT NULL,
    [Brief] nvarchar(max) NOT NULL,
    [Address] nvarchar(100) NULL,
    CONSTRAINT [PK_Technical] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Technical_AspNetUsers_AppUserId] FOREIGN KEY ([AppUserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [CustomerTechnical] (
    [Blocked_Customers_IdId] int NOT NULL,
    [Blocked_Technicals_IdId] int NOT NULL,
    CONSTRAINT [PK_CustomerTechnical] PRIMARY KEY ([Blocked_Customers_IdId], [Blocked_Technicals_IdId]),
    CONSTRAINT [FK_CustomerTechnical_Customer_Blocked_Customers_IdId] FOREIGN KEY ([Blocked_Customers_IdId]) REFERENCES [Customer] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_CustomerTechnical_Technical_Blocked_Technicals_IdId] FOREIGN KEY ([Blocked_Technicals_IdId]) REFERENCES [Technical] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Problems] (
    [Problem_ID] int NOT NULL IDENTITY,
    [Problem_Title] nvarchar(20) NOT NULL,
    [Description] nvarchar(300) NOT NULL,
    [Solved] bit NOT NULL,
    [Section_ID] int NOT NULL,
    [Technical_ID] int NULL,
    [Customer_ID] int NOT NULL,
    CONSTRAINT [PK_Problems] PRIMARY KEY ([Problem_ID]),
    CONSTRAINT [FK_Problems_Customer_Customer_ID] FOREIGN KEY ([Customer_ID]) REFERENCES [Customer] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Problems_Sections_Section_ID] FOREIGN KEY ([Section_ID]) REFERENCES [Sections] ([Section_ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Problems_Technical_Technical_ID] FOREIGN KEY ([Technical_ID]) REFERENCES [Technical] ([Id])
);
GO

CREATE TABLE [SectionTechnical] (
    [SectionsSection_ID] int NOT NULL,
    [TechnicalsId] int NOT NULL,
    CONSTRAINT [PK_SectionTechnical] PRIMARY KEY ([SectionsSection_ID], [TechnicalsId]),
    CONSTRAINT [FK_SectionTechnical_Sections_SectionsSection_ID] FOREIGN KEY ([SectionsSection_ID]) REFERENCES [Sections] ([Section_ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_SectionTechnical_Technical_TechnicalsId] FOREIGN KEY ([TechnicalsId]) REFERENCES [Technical] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [KeyWordsProblem] (
    [KeyWordsKeyWord_ID] int NOT NULL,
    [ProblemsProblem_ID] int NOT NULL,
    CONSTRAINT [PK_KeyWordsProblem] PRIMARY KEY ([KeyWordsKeyWord_ID], [ProblemsProblem_ID]),
    CONSTRAINT [FK_KeyWordsProblem_KeyWords_KeyWordsKeyWord_ID] FOREIGN KEY ([KeyWordsKeyWord_ID]) REFERENCES [KeyWords] ([KeyWord_ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_KeyWordsProblem_Problems_ProblemsProblem_ID] FOREIGN KEY ([ProblemsProblem_ID]) REFERENCES [Problems] ([Problem_ID]) ON DELETE CASCADE
);
GO

CREATE TABLE [Problems_Photo] (
    [Id] int NOT NULL IDENTITY,
    [Photo] varbinary(max) NOT NULL,
    [Problem_ID] int NOT NULL,
    CONSTRAINT [PK_Problems_Photo] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Problems_Photo_Problems_Problem_ID] FOREIGN KEY ([Problem_ID]) REFERENCES [Problems] ([Problem_ID]) ON DELETE CASCADE
);
GO

CREATE TABLE [Reports] (
    [Id] int NOT NULL IDENTITY,
    [Review_ID] int NOT NULL,
    [Causes] int NOT NULL,
    [Description] nvarchar(max) NULL,
    [Created_Date] datetime2 NOT NULL,
    [TechnicalId] int NULL,
    CONSTRAINT [PK_Reports] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Reports_Technical_TechnicalId] FOREIGN KEY ([TechnicalId]) REFERENCES [Technical] ([Id])
);
GO

CREATE TABLE [Reviews] (
    [ID] int NOT NULL IDENTITY,
    [Customer_ID] int NOT NULL,
    [Technical_ID] int NOT NULL,
    [Description] nvarchar(max) NOT NULL,
    [date] datetime2 NOT NULL,
    [Report_ID] int NULL,
    CONSTRAINT [PK_Reviews] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_Reviews_Customer_Customer_ID] FOREIGN KEY ([Customer_ID]) REFERENCES [Customer] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Reviews_Reports_Report_ID] FOREIGN KEY ([Report_ID]) REFERENCES [Reports] ([Id]),
    CONSTRAINT [FK_Reviews_Technical_Technical_ID] FOREIGN KEY ([Technical_ID]) REFERENCES [Technical] ([Id]) ON DELETE CASCADE
);
GO

CREATE UNIQUE INDEX [IX_Admin_AppUserId] ON [Admin] ([AppUserId]);
GO

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
GO

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
GO

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
GO

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
GO

CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;
GO

CREATE UNIQUE INDEX [IX_Customer_AppUserId] ON [Customer] ([AppUserId]);
GO

CREATE INDEX [IX_CustomerTechnical_Blocked_Technicals_IdId] ON [CustomerTechnical] ([Blocked_Technicals_IdId]);
GO

CREATE INDEX [IX_KeyWordsProblem_ProblemsProblem_ID] ON [KeyWordsProblem] ([ProblemsProblem_ID]);
GO

CREATE INDEX [IX_Problems_Customer_ID] ON [Problems] ([Customer_ID]);
GO

CREATE INDEX [IX_Problems_Section_ID] ON [Problems] ([Section_ID]);
GO

CREATE INDEX [IX_Problems_Technical_ID] ON [Problems] ([Technical_ID]);
GO

CREATE INDEX [IX_Problems_Photo_Problem_ID] ON [Problems_Photo] ([Problem_ID]);
GO

CREATE INDEX [IX_Reports_Review_ID] ON [Reports] ([Review_ID]);
GO

CREATE INDEX [IX_Reports_TechnicalId] ON [Reports] ([TechnicalId]);
GO

CREATE INDEX [IX_Reviews_Customer_ID] ON [Reviews] ([Customer_ID]);
GO

CREATE INDEX [IX_Reviews_Report_ID] ON [Reviews] ([Report_ID]);
GO

CREATE INDEX [IX_Reviews_Technical_ID] ON [Reviews] ([Technical_ID]);
GO

CREATE INDEX [IX_SectionTechnical_TechnicalsId] ON [SectionTechnical] ([TechnicalsId]);
GO

CREATE UNIQUE INDEX [IX_Technical_AppUserId] ON [Technical] ([AppUserId]);
GO

ALTER TABLE [Reports] ADD CONSTRAINT [FK_Reports_Reviews_Review_ID] FOREIGN KEY ([Review_ID]) REFERENCES [Reviews] ([ID]) ON DELETE CASCADE;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230414130438_intial', N'7.0.5');
GO

COMMIT;
GO

