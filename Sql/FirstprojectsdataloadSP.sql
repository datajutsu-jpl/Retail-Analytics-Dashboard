USE FirstProject;
GO
--creating strore procedure for bulk insert 
CREATE PROCEDURE sp_load_raw_feed
AS
BEGIN
    BEGIN TRY
        BULK INSERT stg_raw_feed --loading to table nname 
        FROM 'D:\INTPREP\Project\mock_retail\retail_raw_feed.csv'  --file location
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        PRINT 'Load completed successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error loading file: ' + ERROR_MESSAGE();
    END CATCH
END;


