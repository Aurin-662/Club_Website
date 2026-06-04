IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('dbo.PendingJobs') AND type = 'U')
BEGIN
	CREATE TABLE dbo.PendingJobs (
		PendingID INT IDENTITY(1,1) PRIMARY KEY,
		JobTitle NVARCHAR(500) NULL,
		CompanyName NVARCHAR(250) NULL,
		ContactEmail NVARCHAR(250) NULL,
		CompanyWebsite NVARCHAR(500) NULL,
		Department NVARCHAR(200) NULL,
		JobType NVARCHAR(100) NULL,
		Description NVARCHAR(MAX) NULL,
		SubmittedAt DATETIME NULL DEFAULT(GETDATE())
	);
END
