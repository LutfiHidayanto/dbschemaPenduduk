DROP TABLE IF EXISTS [IMIGRAN];
DROP TABLE IF EXISTS [MIGRASI];
DROP TABLE IF EXISTS [LAYANAN_SOSIAL];
DROP TABLE IF EXISTS [PAJAK];
DROP TABLE IF EXISTS [PEKERJAAN];
DROP TABLE IF EXISTS [KEWARGANEGARAAN4];
DROP TABLE IF EXISTS [KOTA];
DROP TABLE IF EXISTS [KESEHATAN];
DROP TABLE IF EXISTS [PENDIDIKAN];
DROP TABLE IF EXISTS [DOKUMEN_IDENTITAS];
DROP TABLE IF EXISTS [KEUANGAN];
DROP TABLE IF EXISTS [KEMATIAN];
DROP TABLE IF EXISTS [KELAHIRAN];
DROP TABLE IF EXISTS [KELUARGA];
DROP TABLE IF EXISTS [PERNIKAHAN];
DROP TABLE IF EXISTS [PENDUDUK];
DROP TABLE IF EXISTS [ORANG];
-- berkaitan dengan identitas
CREATE TABLE [ORANG] (
    [Id_orang] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Nama_depan] VARCHAR(32),
    [Nama_belakang] VARCHAR(32),
    [Jenis_kelamin] VARCHAR(1),
    [Status_pernikahan] VARCHAR(1)
);

-- subclass of orang
CREATE TABLE [PENDUDUK] (
    [Id_orang] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Tempat_lahir] VARCHAR(64), --update later 

    CONSTRAINT [SUB_Penduduk_Orang] 
        FOREIGN KEY([Id_orang]) REFERENCES [ORANG] ([Id_orang])
);

CREATE TABLE [IMIGRAN] (
    [Id_orang] UNIQUEIDENTIFIER DEFAULT NEWID(), 
    [Lama_tinggal] INT NOT NULL,

    CONSTRAINT [SUB_Imigran_Orang] 
        FOREIGN KEY([Id_orang]) REFERENCES [ORANG]([Id_orang])
);

CREATE TABLE [PERNIKAHAN] (
    [Id_pernikahan] UNIQUEIDENTIFIER DEFAULT NEWID(), 
    [Tanggal] DATE NOT NULL, 
    [Tempat] VARCHAR(64),

    -- foreign key
    [Id_pria] UNIQUEIDENTIFIER NOT NULL, 
    [Id_wanita] UNIQUEIDENTIFIER NOT NULL,

    CONSTRAINT [FK_Pernikahan_Orang_Pria]
        FOREIGN KEY ([Id_pria]) REFERENCES [ORANG] ([Id_orang]),

    CONSTRAINT [FK_Pernikahan_Orang_Wanita]
        FOREIGN KEY ([Id_wanita]) REFERENCES [ORANG] ([Id_orang]),
);

CREATE TABLE [KELUARGA] (
    [Id_KK] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [Alamat] VARCHAR(64), -- need update later

    -- fk
    [Id_kepala_keluarga] UNIQUEIDENTIFIER NOT NULL,

    CONSTRAINT [FK_keluarga_orang]
        FOREIGN KEY ([Id_kepala_keluarga]) REFERENCES [ORANG] ([Id_orang])
);

CREATE TABLE [KELAHIRAN] (
    [Id_Akta] UNIQUEIDENTIFIER DEFAULT NEWID(), 
    [Tempat] VARCHAR(64), -- need update later
    [Tanggal] DATE,

    -- fk
    
);

CREATE TABLE [KEMATIAN] (
    [Id_akta] UNIQUEIDENTIFIER DEFAULT NEWID(), 
    [Tempat] VARCHAR(64), -- need update later
    [Tanggal] DATE,

    -- fk
);

CREATE TABLE [KEUANGAN] (
    [Id_laporan] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [Tahun] INT,
    [Pengeluaran] INT,
    [Nilai_asset_total] INT
);
-- update later, include/not
CREATE TABLE [DOKUMEN_IDENTITAS] (
    [No_dokumen] INT,
    [Jenis_dokumen] VARCHAR(32),
    --fk
    [Id_orang] UNIQUEIDENTIFIER,

    CONSTRAINT [FK_weak_dokumenIdentitas_orang]
        FOREIGN KEY ([Id_orang]) REFERENCES [ORANG] ([Id_orang])
);

CREATE TABLE [PENDIDIKAN] (
    [Id_instansi] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [Jenjang] VARCHAR(32), -- update later
    [Nama_Instansi] VARCHAR(64)
);

CREATE TABLE [KESEHATAN] (
    [Id_kesehatan] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [Nama_penyakit] VARCHAR(32),

    [Tanggal] DATE
);



-- 

CREATE TABLE [KOTA] (
    [Id_kota] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [Nama_kota] VARCHAR(64),
    [Jumlah_penghuni] INT 
);

CREATE TABLE [KEWARGANEGARAAN] (
    [Id_negara] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [Nama_negara] VARCHAR(32) 
);

-- UPDATE LATER

CREATE TABLE [PEKERJAAN] (
    [Id_pekerjaan] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [Nama_pekerjaan] VARCHAR(64)
);

CREATE TABLE [PAJAK] (
    [Npwp_tahun] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [Jumlah_pajak_total] INT,
    [Tahun] INT,
    [Status] VARCHAR(1),
);

CREATE TABLE [LAYANAN_SOSIAL] (
    [Id_layanan] UNIQUEIDENTIFIER DEFAULT NEWID(), 
    [Jenis] VARCHAR(64),
    [Nama_layanan] VARCHAR(64)
);

CREATE TABLE [MIGRASI] (
    [Id_migrasi] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Jenis_migrasi] VARCHAR(32),
    [Tanggal] DATE,
    [Status] VARCHAR(32),

);

CREATE TABLE [IMIGRASI] (
    [Id_migrasi] UNIQUEIDENTIFIER PRIMARY KEY,
    [Alasan_imigrasi] VARCHAR(64),

    CONSTRAINT [SUB_imigrasi_migrasi]
        FOREIGN KEY ([Id_migrasi]) REFERENCES [MIGRASI] ([Id_migrasi])
);

CREATE TABLE [MIGRASI_ANTAR_DAERAH] (
    [Id_migrasi] UNIQUEIDENTIFIER PRIMARY KEY,
    [Alasan_migrasi] VARCHAR(64),

);

CREATE TABLE [STATISTIK_MIGRASI] (
    [Id_statistik] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Tahun] INT,
    [Jumlah_migrasi_keluar] INT,
    [Jumlah_migrasi_masuk] INT
);