CREATE TABLE :"registry".releases (
    version         FLOAT          PRIMARY KEY,
    installed_at    TIMESTAMPTZ    NOT NULL DEFAULT clock_timestamp(),
    installer_name  VARCHAR(1024)  NOT NULL,
    installer_email VARCHAR(1024)  NOT NULL
);

COMMENT ON TABLE  :"registry".releases IS 'Sqitch registry releases.';

-- Add the script_hash column to the changes table. Copy change_id for now.
ALTER TABLE :"registry".changes ADD COLUMN script_hash CHAR(40);
UPDATE :"registry".changes SET script_hash = change_id;
ALTER TABLE :"registry".changes ADD UNIQUE(script_hash);

COMMENT ON SCHEMA :"registry" IS 'Sqitch database deployment metadata v1.0.';
