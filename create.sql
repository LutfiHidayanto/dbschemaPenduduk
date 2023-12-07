DROP TABLE IF EXISTS [STATISTIK_MIGRASI];
DROP TABLE IF EXISTS [MIGRASI_ANTAR_DAERAH];
DROP TABLE IF EXISTS [IMIGRASI];
DROP TABLE IF EXISTS [MIGRASI];
DROP TABLE IF EXISTS [IMIGRAN];
DROP TABLE IF EXISTS [MEMILIKI_LAYANAN_SOSIAL]
DROP TABLE IF EXISTS [LAYANAN_SOSIAL];
DROP TABLE IF EXISTS [PAJAK];
DROP TABLE IF EXISTS [KEWARGANEGARAAN4];
DROP TABLE IF EXISTS [KOTA];
DROP TABLE IF EXISTS [KESEHATAN];
DROP TABLE IF EXISTS [PENDIDIKAN];
DROP TABLE IF EXISTS [DOKUMEN_IDENTITAS];
DROP TABLE IF EXISTS [KEUANGAN];
DROP TABLE IF EXISTS [KEMATIAN];
DROP TABLE IF EXISTS [KELUARGA];
DROP TABLE IF EXISTS [PERNIKAHAN];
DROP TABLE IF EXISTS [PENDUDUK];
DROP TABLE IF EXISTS [KELAHIRAN];
DROP TABLE IF EXISTS [ORANG];
DROP TABLE IF EXISTS [PEKERJAAN];
DROP TABLE IF EXISTS [ALAMAT];
DROP TABLE IF EXISTS [KEWARGANEGARAAN];


CREATE TABLE [PEKERJAAN] (
    [Id_pekerjaan] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Nama_pekerjaan] VARCHAR(64)
);

-- berkaitan dengan identitas
CREATE TABLE [ORANG] (
    [Id_orang] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Nama_depan] VARCHAR(32) NOT NULL,
    [Nama_belakang] VARCHAR(32) NOT NULL,
    [Jenis_kelamin] VARCHAR(1) NOT NULL,
    [Status_pernikahan] VARCHAR(1) NOT NULL,
    [Id_pekerjaan] UNIQUEIDENTIFIER,

    -- fk
    CONSTRAINT [FK_orang_pekerjaan]
        FOREIGN KEY ([Id_pekerjaan]) REFERENCES [PEKERJAAN] ([Id_pekerjaan]) 
);

CREATE TABLE [ALAMAT] (
    [Id_alamat] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Provinsi] VARCHAR(32) NOT NULL,
    [Kabupaten] VARCHAR(64) NOT NULL,
    [Kecamatan] VARCHAR(64) NOT NULL,
    [RT] INT NOT NULL,
    [RW] INT NOT NULL,
    [Kode_pos] INT NOT NULL
);

CREATE TABLE [KELAHIRAN] (
    [Id_akta] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(), 
    [Tanggal] DATE NOT NULL,
    [Id_tempat] UNIQUEIDENTIFIER NOT NULL, -- need update later

    -- fk
    CONSTRAINT [FK_kelahiran_alamat] 
        FOREIGN KEY ([Id_tempat]) REFERENCES [ALAMAT] ([Id_alamat]) ON DELETE CASCADE
);

-- subclass of orang
CREATE TABLE [PENDUDUK] (
    [Id_orang] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Tempat_lahir] VARCHAR(64), --update later 
    [Id_akta] UNIQUEIDENTIFIER, -- might need to reconsider

    -- subclass
    CONSTRAINT [SUB_Penduduk_Orang] 
        FOREIGN KEY([Id_orang]) REFERENCES [ORANG] ([Id_orang]),
    -- fk
    CONSTRAINT [FK_penduduk_kelahiran] 
        FOREIGN KEY ([Id_akta]) REFERENCES [KELAHIRAN] ([Id_akta])
);



CREATE TABLE [IMIGRAN] (
    [Id_orang] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(), 
    [Lama_tinggal] INT,

    CONSTRAINT [SUB_Imigran_Orang] 
        FOREIGN KEY([Id_orang]) REFERENCES [ORANG]([Id_orang])
);

CREATE TABLE [PERNIKAHAN] (
    [Id_pernikahan] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(), 
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
    [Id_KK] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Alamat] VARCHAR(64), -- need update later

    -- fk
    [Id_kepala_keluarga] UNIQUEIDENTIFIER NOT NULL,

    CONSTRAINT [FK_keluarga_orang]
        FOREIGN KEY ([Id_kepala_keluarga]) REFERENCES [ORANG] ([Id_orang]) ON DELETE CASCADE
);



CREATE TABLE [KEMATIAN] (
    [Id_akta] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(), 
    [Tanggal] DATE,
    [Id_tempat] UNIQUEIDENTIFIER, -- need update later

    -- fk
    CONSTRAINT [FK_kematina_alamat] 
        FOREIGN KEY ([Id_tempat]) REFERENCES [ALAMAT] ([Id_alamat]) ON DELETE CASCADE
);

CREATE TABLE [KEUANGAN] (
    [Id_laporan] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Tahun] INT,
    [Pengeluaran] INT,
    [Nilai_asset_total] INT
);

CREATE TABLE [PENDIDIKAN] (
    [Id_instansi] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Jenjang] VARCHAR(32), -- update later
    [Nama_Instansi] VARCHAR(64)
);

CREATE TABLE [KESEHATAN] (
    [Id_kesehatan] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Nama_penyakit] VARCHAR(32),

    [Tanggal] DATE
);



-- 

CREATE TABLE [KOTA] (
    [Id_kota] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Nama_kota] VARCHAR(64),
    [Jumlah_penghuni] INT 
);

CREATE TABLE [KEWARGANEGARAAN] (
    [Id_negara] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Nama_negara] VARCHAR(32) 
);

-- UPDATE LATER


CREATE TABLE [PAJAK] (
    [Npwp_tahun] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Jumlah_pajak_total] INT,
    [Tahun] INT,
    [Status] VARCHAR(1),

    [Id_laporan] UNIQUEIDENTIFIER,

    -- fk
    CONSTRAINT [FK_pajak_keuangan] 
        FOREIGN KEY ([Id_laporan]) REFERENCES [KEUANGAN] ([Id_laporan]) 
);

CREATE TABLE [LAYANAN_SOSIAL] (
    [Id_layanan] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(), 
    [Jenis] VARCHAR(64),
    [Nama_layanan] VARCHAR(64)
);

-- M:M layanan sosial-orang
CREATE TABLE [MEMILIKI_LAYANAN_SOSIAL] (
    [Id_orang] UNIQUEIDENTIFIER,
    [Id_layanan] UNIQUEIDENTIFIER,

    PRIMARY KEY ([Id_orang],Id_layanan),

    CONSTRAINT [FKM_mlayanansosial_orang]
        FOREIGN KEY ([Id_orang]) REFERENCES [ORANG] ([Id_orang]),

    CONSTRAINT [FKM_mlayanansosial_layanan]
        FOREIGN KEY([Id_layanan]) REFERENCES [LAYANAN_SOSIAL] ([Id_layanan])
)

CREATE TABLE [MIGRASI] (
    [Id_migrasi] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Jenis_migrasi] VARCHAR(32),
    [Tanggal] DATE,
    [Status] VARCHAR(32),

);

CREATE TABLE [IMIGRASI] (
    [Id_migrasi] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Alasan_imigrasi] VARCHAR(64),

    CONSTRAINT [SUB_imigrasi_migrasi]
        FOREIGN KEY ([Id_migrasi]) REFERENCES [MIGRASI] ([Id_migrasi])
);

CREATE TABLE [MIGRASI_ANTAR_DAERAH] (
    [Id_migrasi] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Alasan_migrasi] VARCHAR(64),

);

CREATE TABLE [STATISTIK_MIGRASI] (
    [Id_statistik] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [Tahun] INT,
    [Jumlah_migrasi_keluar] INT,
    [Jumlah_migrasi_masuk] INT
);

-- Manytomany