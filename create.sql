DROP TABLE IF EXISTS [STATISTIK_MIGRASI];
DROP TABLE IF EXISTS [MELAKUKAN_MIGRASI];
DROP TABLE IF EXISTS [MIGRASI_ANTAR_DAERAH];
DROP TABLE IF EXISTS [IMIGRASI];
DROP TABLE IF EXISTS [MIGRASI];
DROP TABLE IF EXISTS [IMIGRAN];
DROP TABLE IF EXISTS [MEMILIKI_LAYANAN_SOSIAL]
DROP TABLE IF EXISTS [LAYANAN_SOSIAL];
DROP TABLE IF EXISTS [JENIS_PAJAK];
DROP TABLE IF EXISTS [PAJAK];
DROP TABLE IF EXISTS [BERKEWARGANEGARAAN];
DROP TABLE IF EXISTS [KESEHATAN];
DROP TABLE IF EXISTS [MENEMPUH_PENDIDIKAN];
DROP TABLE IF EXISTS [PENDIDIKAN];
DROP TABLE IF EXISTS [ASSET];
DROP TABLE IF EXISTS [KEUANGAN];
DROP TABLE IF EXISTS [KEMATIAN];
DROP TABLE IF EXISTS [PERNIKAHAN];
DROP TABLE IF EXISTS [KELAHIRAN];
DROP TABLE IF EXISTS [PENDUDUK];
DROP TABLE IF EXISTS [MEMILIKI_ALAMAT];
ALTER TABLE KELUARGA DROP CONSTRAINT FK_keluarga_orang; -- Drop the constraint in KELUARGA table
DROP TABLE IF EXISTS [ORANG];
DROP TABLE IF EXISTS [KELUARGA];
DROP TABLE IF EXISTS [PEKERJAAN];
DROP TABLE IF EXISTS [ALAMAT_PERUSAHAAN];
DROP TABLE IF EXISTS [ALAMAT];
DROP TABLE IF EXISTS [PERUSAHAAN];
DROP TABLE IF EXISTS [KEWARGANEGARAAN];
DROP TABLE IF EXISTS [NEGARA];
DROP TABLE IF EXISTS [KOTA];


CREATE TABLE [PEKERJAAN] (
    [Id_pekerjaan] INT PRIMARY KEY,
    [Nama_pekerjaan] VARCHAR(64)
);

CREATE TABLE [KOTA] (
    [Id_kota] INT PRIMARY KEY,
    [Nama_kota] VARCHAR(64),
    [Jumlah_penghuni] INT
);

CREATE TABLE [NEGARA] (
    [Id_negara] INT PRIMARY KEY,
    [Nama_negara] VARCHAR(32) NOT NULL
);
-- new
CREATE TABLE [PERUSAHAAN] (
    [Id_perusahaan] INT PRIMARY KEY,
    [Nama_perusahaan] VARCHAR(64) NOT NULL,
    [Jenis] VARCHAR(10) NOT NULL,
    [Sektor] VARCHAR(32) NOT NULL,
    [No_telp] VARCHAR(16) NOT NULL,
);

-- Multi valued Alamat perusahaan
CREATE TABLE [ALAMAT_PERUSAHAAN] (
    [Id_perusahaan] INT, 
    [No_jalan] VARCHAR(64),
    [Kecamatan] VARCHAR(32),
    [Kota] VARCHAR(32),
    [Kode_pos] VARCHAR(32),
    [Provinsi] VARCHAR(32),

    PRIMARY KEY([Id_perusahaan], [No_Jalan]),

    CONSTRAINT [Multi_alamat_perusahaan] 
        FOREIGN KEY ([Id_perusahaan]) REFERENCES [PERUSAHAAN] ([Id_perusahaan])
)



-- berkaitan dengan identitas
CREATE TABLE [ALAMAT] (
    [Id_alamat] INT PRIMARY KEY,
    [RT] INT,
    [RW] INT,
    [Id_kota] INT NOT NULL,
    [Kecamatan] VARCHAR(64) NOT NULL,
    [Provinsi] VARCHAR(32) NOT NULL,
    [Kode_pos] INT NOT NULL,
    
    -- FK

    CONSTRAINT [FK_alamat_kota] 
        FOREIGN KEY ([Id_kota]) REFERENCES [KOTA] ([Id_kota])

);

CREATE TABLE [KELUARGA] (
    [Id_KK] VARCHAR(20) PRIMARY KEY,

    -- fk
    [Id_kepala_keluarga] VARCHAR(22),
    [Id_alamat] INT NOT NULL,

    -- CONSTRAINT [FK_keluarga_orang]
    --     FOREIGN KEY ([Id_kepala_keluarga]) REFERENCES [ORANG] ([Id_orang]),
    CONSTRAINT [FK_keluarga_alamat]
        FOREIGN KEY ([Id_alamat]) REFERENCES [ALAMAT] ([Id_alamat]) ON DELETE CASCADE
);

CREATE TABLE [ORANG] (
    [Id_orang] VARCHAR(22) PRIMARY KEY,
    [Nama_depan] VARCHAR(32) NOT NULL,
    [Nama_tengah] VARCHAR(32),
    [Nama_belakang] VARCHAR(32),
    -- [Hari_lahir] INT NOT NULL, 
    -- [Bulan_lahir] INT NOT NULL,
    -- [Tahun_lahir] INT NOT NULL,
    [Tanggal_lahir] DATE,
    [Jenis_kelamin] VARCHAR(1) NOT NULL,
    [Golongan_darah] VARCHAR(3),
    [Status_menikah] VARCHAR(7) NOT NULL,

    -- fk
    [Id_pekerjaan] INT,
    [Id_KK] VARCHAR(20),
    [Id_kota] INT,

    -- fk
    CONSTRAINT [FK_orang_pekerjaan]
        FOREIGN KEY ([Id_pekerjaan]) REFERENCES [PEKERJAAN] ([Id_pekerjaan]) ON DELETE CASCADE,
    CONSTRAINT [FK_orang_keluarga]
        FOREIGN KEY ([Id_KK]) REFERENCES [KELUARGA] ([Id_KK]) ON DELETE CASCADE,
    CONSTRAINT [FK_orang_kota]
        FOREIGN KEY ([Id_kota]) REFERENCES [KOTA] ([Id_kota]) ON DELETE CASCADE
);

-- M:n orang-alamat
CREATE TABLE [MEMILIKI_ALAMAT] (
    [Id_orang] VARCHAR(22),
    [Id_alamat] INT,
    

    PRIMARY KEY ([Id_orang],Id_alamat),

    CONSTRAINT [FKM_memilikiAlamat_orang]
        FOREIGN KEY ([Id_orang]) REFERENCES [ORANG] ([Id_orang]) ON DELETE CASCADE,

    CONSTRAINT [FKM_memilikiAlamat_alamat]
        FOREIGN KEY([Id_alamat]) REFERENCES [ALAMAT] ([Id_alamat])

);

-- subclass of orang
CREATE TABLE [PENDUDUK] (
    [Id_orang] VARCHAR(22) PRIMARY KEY,
    [Agama] VARCHAR(10),
    [Suku] VARCHAR(32) 
    -- [Id_akta] INT, -- might need to reconsider

    -- subclass
    CONSTRAINT [SUB_Penduduk_Orang] 
        FOREIGN KEY([Id_orang]) REFERENCES [ORANG] ([Id_orang]) ON DELETE CASCADE,
    -- fk
    -- CONSTRAINT [FK_penduduk_kelahiran] 
    --     FOREIGN KEY ([Id_akta]) REFERENCES [KELAHIRAN] ([Id_akta])
);


CREATE TABLE [KELAHIRAN] (
    [Id_akta] INT PRIMARY KEY, 
    [Tanggal] DATE NOT NULL,
    [Id_tempat] INT NOT NULL, 
    -- [Id_KK] UNIQUEIDENTIFIER NOT NULL, -- might need update later
    [Id_orang] VARCHAR(22) NOT NULL,

    -- fk
    CONSTRAINT [FK_kelahiran_alamat] 
        FOREIGN KEY ([Id_tempat]) REFERENCES [ALAMAT] ([Id_alamat]),
    CONSTRAINT [FK_kelahiran_orang]
        FOREIGN KEY ([Id_orang]) REFERENCES [PENDUDUK] ([Id_orang]) ON DELETE CASCADE

);

CREATE TABLE [KEMATIAN] (
    [Id_akta] INT PRIMARY KEY, 
    [Tanggal] DATE NOT NULL,
    [Id_tempat] INT NOT NULL, -- need update later
    [Id_orang] VARCHAR(22) NOT NULL,

    -- fk
    CONSTRAINT [FK_kematian_alamat] 
        FOREIGN KEY ([Id_tempat]) REFERENCES [ALAMAT] ([Id_alamat]),
    CONSTRAINT [FK_kematian_orang]
        FOREIGN KEY ([Id_orang]) REFERENCES [ORANG] ([Id_orang]) ON DELETE CASCADE

);


CREATE TABLE [IMIGRAN] (
    [Id_orang] VARCHAR(22) PRIMARY KEY, 
    [Lama_tinggal] INT,
    [Status] VARCHAR(32),

    CONSTRAINT [SUB_Imigran_Orang] 
        FOREIGN KEY([Id_orang]) REFERENCES [ORANG]([Id_orang]) ON DELETE CASCADE
);

-- M:N imigran-kewarganegaraan
CREATE TABLE [BERKEWARGANEGARAAN] (
    [Id_orang] VARCHAR(22) NOT NULL,
    [Id_negara] INT,

    PRIMARY KEY ([Id_orang], [Id_negara]),

    -- fk
    CONSTRAINT [FKM_berkewarganegaraan_orang]
        FOREIGN KEY ([Id_orang]) REFERENCES [ORANG] ([Id_orang]) ON DELETE CASCADE,

    CONSTRAINT [FKM_berkewarganegaraan_negara]
        FOREIGN KEY([Id_negara]) REFERENCES [NEGARA] ([Id_negara]) ON DELETE CASCADE
)

CREATE TABLE [PERNIKAHAN] (
    [Id_pernikahan] INT PRIMARY KEY, 
    [Tanggal] DATE NOT NULL, 
    [Tempat] VARCHAR(64),

    -- foreign key
    [Id_pria] VARCHAR(22) NOT NULL, 
    [Id_wanita] VARCHAR(22) NOT NULL,

    CONSTRAINT [FK_Pernikahan_Orang_Pria]
        FOREIGN KEY ([Id_pria]) REFERENCES [ORANG] ([Id_orang]),

    CONSTRAINT [FK_Pernikahan_Orang_Wanita]
        FOREIGN KEY ([Id_wanita]) REFERENCES [ORANG] ([Id_orang]),
);

CREATE TABLE [KEUANGAN] (
    [Id_laporan] INT PRIMARY KEY,
    [Tahun] INT,
    [Pengeluaran] INT,
    [Pendapatan] INT,
    [Nilai_asset_total] INT,

    -- FK
    [Id_orang] VARCHAR(22),
    CONSTRAINT [FK_keuangan_orang]
        FOREIGN KEY ([Id_orang]) REFERENCES [ORANG] ([Id_orang]) ON DELETE CASCADE
);
-- multivalue of keuangan
CREATE TABLE [ASSET] (
    [Id_laporan] INT,
    [Nama] VARCHAR(64),
    [Nilai] INT NOT NULL,

    CONSTRAINT [Multi_asset_keuangan]
        FOREIGN KEY ([Id_laporan]) REFERENCES [KEUANGAN] ([Id_laporan]) ON DELETE CASCADE, 
)

CREATE TABLE [PAJAK] (
    [Id_npwp_tahun] VARCHAR(22) PRIMARY KEY,
    [Jumlah_pajak_total] INT, -- migth need name change
    [Tahun] INT,
    [Status] VARCHAR(5),

    [Id_laporan] INT,
    [Id_orang] VARCHAR(22),
    -- fk
    CONSTRAINT [FK_pajak_keuangan] 
        FOREIGN KEY ([Id_laporan]) REFERENCES [KEUANGAN] ([Id_laporan]),
    CONSTRAINT [FK_pajak_orang] 
        FOREIGN KEY ([Id_orang]) REFERENCES [ORANG] ([Id_orang]) ON DELETE CASCADE
    
);
-- multivalue of pajak
CREATE TABLE [JENIS_PAJAK] (
    [Id_npwp_tahun] VARCHAR(22),
    [Jenis] VARCHAR(32),
    [Nilai] INT,

    PRIMARY KEY([Id_npwp_tahun], [Jenis]),
    CONSTRAINT [Multi_jenispajak_pajak] 
        FOREIGN KEY ([Id_npwp_tahun]) REFERENCES [PAJAK] ([Id_npwp_tahun]) ON DELETE CASCADE
)

CREATE TABLE [PENDIDIKAN] (
    [Id_instansi] VARCHAR(10) PRIMARY KEY,
    [Jenjang] VARCHAR(32), -- update later
    [Nama_Instansi] VARCHAR(64)
);

-- M:N orang-pendidikan
CREATE TABLE [MENEMPUH_PENDIDIKAN] (
    [Id_orang] VARCHAR(22),
    [Id_instansi] VARCHAR(10),

    PRIMARY KEY ([Id_orang],Id_instansi),

    CONSTRAINT [FKM_menempuhPendidikan_orang]
        FOREIGN KEY ([Id_orang]) REFERENCES [ORANG] ([Id_orang]),

    CONSTRAINT [FKM_menempuhPendidikan_pendidikan]
        FOREIGN KEY([Id_instansi]) REFERENCES [PENDIDIKAN] ([Id_instansi])
)

CREATE TABLE [KESEHATAN] (
    [Id_kesehatan] INT PRIMARY KEY,
    [Penyakit] VARCHAR(32), -- might need name change
    [Tanggal] DATE,

    -- fk
    [Id_orang] VARCHAR(22),

    CONSTRAINT [FK_kesehatan_orang] 
        FOREIGN KEY ([Id_orang]) REFERENCES [ORANG] ([Id_orang]) ON DELETE CASCADE
);

-- UPDATE LATER



CREATE TABLE [LAYANAN_SOSIAL] (
    [Id_layanan] VARCHAR(10) PRIMARY KEY, 
    [Jenis] VARCHAR(64),
    [Nama_layanan] VARCHAR(64)
);

-- M:M layanan sosial-orang
CREATE TABLE [MEMILIKI_LAYANAN_SOSIAL] (
    [Id_orang] VARCHAR(22) NOT NULL,
    [Id_layanan] VARCHAR(10),
    [Mulai_berlaku] DATE,
    [Tanggal_expired] DATE,


    PRIMARY KEY ([Id_orang],Id_layanan),

    CONSTRAINT [FKM_mlayanansosial_orang]
        FOREIGN KEY ([Id_orang]) REFERENCES [ORANG] ([Id_orang]),

    CONSTRAINT [FKM_mlayanansosial_layanan]
        FOREIGN KEY([Id_layanan]) REFERENCES [LAYANAN_SOSIAL] ([Id_layanan])
)

CREATE TABLE [MIGRASI] (
    [Id_migrasi] INT PRIMARY KEY,
    [Jenis_migrasi] VARCHAR(32),
    [Status] VARCHAR(32),
    [Tanggal] DATE,
);

CREATE TABLE [IMIGRASI] (
    [Id_migrasi] INT PRIMARY KEY,
    [Alasan_imigrasi] VARCHAR(128),
    
    -- fk and sub
    [Id_kota] INT,
    [Id_negara] INT
    CONSTRAINT [SUB_imigrasi_migrasi]
        FOREIGN KEY ([Id_migrasi]) REFERENCES [MIGRASI] ([Id_migrasi]) ON DELETE CASCADE,
    CONSTRAINT [fk_imigrasi_kota]
        FOREIGN KEY ([Id_kota]) REFERENCES [KOTA] ([Id_kota]) ON DELETE CASCADE,
    CONSTRAINT [fk_imigrasi_negara]
        FOREIGN KEY ([Id_negara]) REFERENCES [NEGARA] ([Id_negara]) ON DELETE CASCADE

);

CREATE TABLE [MIGRASI_ANTAR_DAERAH] (
    [Id_migrasi] INT PRIMARY KEY,
    [Alasan_migrasi] VARCHAR(64),
    -- sub
    CONSTRAINT [SUB_migrasiDaerah_migrasi]
        FOREIGN KEY ([Id_migrasi]) REFERENCES [MIGRASI] ([Id_migrasi]) ON DELETE CASCADE,

    -- fk
    [Id_kota_asal] INT NOT NULL,
    [Id_kota_tujuan] INT NOT NULL,

    CONSTRAINT [FK_migrasiDaerah_kotaAsal] 
        FOREIGN KEY ([Id_kota_asal]) REFERENCES [KOTA] ([Id_kota]),
    CONSTRAINT [FK_migrasiDaerah_kotatujuan] 
        FOREIGN KEY ([Id_kota_tujuan]) REFERENCES [KOTA] ([Id_kota])
);
-- M:N migrasi-orang
CREATE TABLE [MELAKUKAN_MIGRASI] (
    [Id_orang] VARCHAR(22),
    [Id_migrasi] INT,

    PRIMARY KEY([Id_orang], [Id_migrasi]),

    CONSTRAINT [Multi_melakukanMigrasi_orang]
        FOREIGN KEY ([Id_orang]) REFERENCES [ORANG] ([Id_orang]),
    CONSTRAINT [Multi_melakukanMigrasi_migrasi]
        FOREIGN KEY ([Id_migrasi]) REFERENCES [MIGRASI] ([Id_migrasi]) ON DELETE CASCADE,

)

CREATE TABLE [STATISTIK_MIGRASI] (
    [Id_statistik] INT PRIMARY KEY,
    [Tahun] INT,
    [Jumlah_migrasi_keluar] INT,
    [Jumlah_migrasi_masuk] INT,

    -- fk
    [Id_kota] INT,

    CONSTRAINT [FK_statistikMigrasi_kota] 
        FOREIGN KEY ([Id_kota]) REFERENCES [KOTA] ([Id_kota])
);

-- alter table menambah fk keluarga
ALTER TABLE [KELUARGA]
ADD CONSTRAINT [FK_keluarga_orang]
    FOREIGN KEY ([Id_kepala_keluarga]) REFERENCES [ORANG] ([Id_orang]);