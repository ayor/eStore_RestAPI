IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003070550_initial')
BEGIN
    CREATE TABLE [Customer] (
        [ID] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NULL,
        [Address] nvarchar(max) NULL,
        [Password] nvarchar(max) NULL,
        CONSTRAINT [PK_Customer] PRIMARY KEY ([ID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003070550_initial')
BEGIN
    CREATE TABLE [Formats] (
        [Id] int NOT NULL IDENTITY,
        [Formats] nvarchar(max) NULL,
        CONSTRAINT [PK_Formats] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003070550_initial')
BEGIN
    CREATE TABLE [Rental] (
        [Id] int NOT NULL IDENTITY,
        [VideoID] int NOT NULL,
        [CustomerID] int NOT NULL,
        [VideoTitle] nvarchar(max) NULL,
        [CustomerName] nvarchar(max) NULL,
        [VideoFormat] nvarchar(max) NULL,
        [RentedQuantity] int NOT NULL,
        [RentalDate] datetime2 NULL,
        [ReturnDate] datetime2 NULL,
        CONSTRAINT [PK_Rental] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003070550_initial')
BEGIN
    CREATE TABLE [Videos] (
        [ID] int NOT NULL IDENTITY,
        [Title] nvarchar(max) NULL,
        [Format] nvarchar(max) NULL,
        [Stock] int NOT NULL,
        CONSTRAINT [PK_Videos] PRIMARY KEY ([ID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003070550_initial')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191003070550_initial', N'2.2.4-servicing-10062');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003070723_seededData')
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Formats') AND [object_id] = OBJECT_ID(N'[Formats]'))
        SET IDENTITY_INSERT [Formats] ON;
    INSERT INTO [Formats] ([Id], [Formats])
    VALUES (1, N'Blueray'),
    (2, N'Hd-Rip'),
    (3, N'Cam-Rip');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Formats') AND [object_id] = OBJECT_ID(N'[Formats]'))
        SET IDENTITY_INSERT [Formats] OFF;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003070723_seededData')
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'CustomerID', N'CustomerName', N'RentalDate', N'RentedQuantity', N'ReturnDate', N'VideoFormat', N'VideoID', N'VideoTitle') AND [object_id] = OBJECT_ID(N'[Rental]'))
        SET IDENTITY_INSERT [Rental] ON;
    INSERT INTO [Rental] ([Id], [CustomerID], [CustomerName], [RentalDate], [RentedQuantity], [ReturnDate], [VideoFormat], [VideoID], [VideoTitle])
    VALUES (1, 1, N'ayo', '2019-10-03T08:07:22.9207052+01:00', 1, NULL, N'Blueray', 1, N'Bat Man');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'CustomerID', N'CustomerName', N'RentalDate', N'RentedQuantity', N'ReturnDate', N'VideoFormat', N'VideoID', N'VideoTitle') AND [object_id] = OBJECT_ID(N'[Rental]'))
        SET IDENTITY_INSERT [Rental] OFF;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003070723_seededData')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191003070723_seededData', N'2.2.4-servicing-10062');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003072200_seedCustomer')
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'ID', N'Address', N'Name', N'Password') AND [object_id] = OBJECT_ID(N'[Customer]'))
        SET IDENTITY_INSERT [Customer] ON;
    INSERT INTO [Customer] ([ID], [Address], [Name], [Password])
    VALUES (1, N'admin', N'admin', N'admin');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'ID', N'Address', N'Name', N'Password') AND [object_id] = OBJECT_ID(N'[Customer]'))
        SET IDENTITY_INSERT [Customer] OFF;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003072200_seedCustomer')
BEGIN
    UPDATE [Rental] SET [RentalDate] = '2019-10-03T08:22:00.2180965+01:00'
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT;

END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003072200_seedCustomer')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191003072200_seedCustomer', N'2.2.4-servicing-10062');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003072812_seededVideos')
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Videos]') AND [c].[name] = N'Format');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Videos] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [Videos] DROP COLUMN [Format];
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003072812_seededVideos')
BEGIN
    UPDATE [Rental] SET [RentalDate] = '2019-10-03T08:28:11.6543133+01:00'
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT;

END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003072812_seededVideos')
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'ID', N'Stock', N'Title') AND [object_id] = OBJECT_ID(N'[Videos]'))
        SET IDENTITY_INSERT [Videos] ON;
    INSERT INTO [Videos] ([ID], [Stock], [Title])
    VALUES (1, 10, N'Test Video');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'ID', N'Stock', N'Title') AND [object_id] = OBJECT_ID(N'[Videos]'))
        SET IDENTITY_INSERT [Videos] OFF;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191003072812_seededVideos')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191003072812_seededVideos', N'2.2.4-servicing-10062');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191006090838_addedRolesToCustomer')
BEGIN
    ALTER TABLE [Customer] ADD [Role] nvarchar(max) NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191006090838_addedRolesToCustomer')
BEGIN
    UPDATE [Customer] SET [Role] = N'admin'
    WHERE [ID] = 1;
    SELECT @@ROWCOUNT;

END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191006090838_addedRolesToCustomer')
BEGIN
    UPDATE [Rental] SET [RentalDate] = '2019-10-06T10:08:37.6069970+01:00'
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT;

END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191006090838_addedRolesToCustomer')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191006090838_addedRolesToCustomer', N'2.2.4-servicing-10062');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191104044850_updatedCustomerModel')
BEGIN
    ALTER TABLE [Customer] ADD [Email] nvarchar(max) NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191104044850_updatedCustomerModel')
BEGIN
    UPDATE [Rental] SET [RentalDate] = '2019-11-04T05:48:47.8686019+01:00'
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT;

END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191104044850_updatedCustomerModel')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191104044850_updatedCustomerModel', N'2.2.4-servicing-10062');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191105091236_removedRole')
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Customer]') AND [c].[name] = N'Role');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Customer] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [Customer] DROP COLUMN [Role];
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191105091236_removedRole')
BEGIN
    UPDATE [Rental] SET [RentalDate] = '2019-11-05T10:12:34.9408974+01:00'
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT;

END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191105091236_removedRole')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191105091236_removedRole', N'2.2.4-servicing-10062');
END;

GO

