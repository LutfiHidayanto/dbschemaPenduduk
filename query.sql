-- imigran
select *, "PEKERJAAN"."Nama_pekerjaan", "KOTA"."Nama_kota" from "ORANG"
JOIN "IMIGRAN" ON "ORANG"."Id_orang" = "IMIGRAN"."Id_orang"
JOIN "PEKERJAAN" ON "ORANG"."Id_pekerjaan" = "PEKERJAAN"."Id_pekerjaan"
JOIN "KOTA" ON "ORANG"."Id_kota_domisili" = "KOTA"."Id_kota"
JOIN "berkewarganegaraan" ON "IMIGRAN"."Id_orang" = "berkewarganegaraan"."Id_orang"
JOIN "NEGARA" ON "NEGARA"."Id_negara" = "berkewarganegaraan"."Id_negara"


-- imigran ssms
select *, "PEKERJAAN"."Nama_pekerjaan", "KOTA"."Nama_kota" from "ORANG"
JOIN "IMIGRAN" ON "ORANG"."Id_orang" = "IMIGRAN"."Id_orang"
JOIN "PEKERJAAN" ON "ORANG"."Id_pekerjaan" = "PEKERJAAN"."Id_pekerjaan"
JOIN "KOTA" ON "ORANG"."Id_kota" = "KOTA"."Id_kota"
JOIN "berkewarganegaraan" ON "IMIGRAN"."Id_orang" = "berkewarganegaraan"."Id_orang"
JOIN "NEGARA" ON "NEGARA"."Id_negara" = "berkewarganegaraan"."Id_negara"

-- kelahiran

SELECT 
    "ORANG"."Id_orang","Id_akta", "Nama_depan", "Nama_tengah", "Nama_belakang", "ORANG"."Id_KK", "KELUARGA"."Id_kepala_keluarga"
FROM "ORANG"
JOIN "KELAHIRAN" ON "ORANG"."Id_orang" = "KELAHIRAN"."Id_orang"
JOIN "ALAMAT" ON "KELAHIRAN"."Id_tempat" = "ALAMAT"."Id_alamat"
JOIN "KELUARGA" ON "KELUARGA"."Id_KK" = "ORANG"."Id_KK" 
    AND "KELUARGA"."Id_kepala_keluarga" = "ORANG"."Id_orang";

SELECT 
    "ORANG"."Id_orang",
    "Id_akta",
    "ORANG"."Nama_depan",
    "ORANG"."Nama_tengah",
    "ORANG"."Nama_belakang",
    "KELAHIRAN"."Tanggal",
	"ALAMAT"."Id_kota",
    "ORANG"."Id_KK",
	CASE WHEN "AYAH"."Nama_depan" = "ORANG"."Nama_depan" THEN NULL ELSE "AYAH"."Nama_depan" END AS "Nama_depan_ayah",
    "IBU"."Nama_depan" AS "Nama_depan_ibu"
FROM "ORANG"
JOIN "KELAHIRAN" ON "ORANG"."Id_orang" = "KELAHIRAN"."Id_orang"
JOIN "ALAMAT" ON "KELAHIRAN"."Id_tempat" = "ALAMAT"."Id_alamat"
JOIN "KELUARGA" ON "KELUARGA"."Id_KK" = "ORANG"."Id_KK" 
LEFT JOIN "ORANG" AS "AYAH" ON "KELUARGA"."Id_kepala_keluarga" = "AYAH"."Id_orang"
LEFT JOIN "PERNIKAHAN" ON "PERNIKAHAN"."Id_pria" = "AYAH"."Id_orang"
LEFT JOIN "ORANG" AS "IBU" ON "IBU"."Id_orang" = "PERNIKAHAN"."id_wanita"
WHERE 
    ("AYAH"."Id_orang" != "ORANG"."Id_orang" OR "IBU"."Id_orang" != "ORANG"."Id_orang")
    OR ("AYAH"."Id_orang" IS NULL OR "IBU"."Id_orang" IS NULL)
ORDER BY "KELAHIRAN"."Id_akta" ASC


SELECT 
    "ORANG"."Id_orang",
    "Id_akta",
    "ORANG"."Nama_depan",
    "ORANG"."Nama_tengah",
    "ORANG"."Nama_belakang",
    "KELAHIRAN"."Tanggal",
	"TEMPATL"."Nama_kota",
    "ORANG"."Id_KK",
	CASE WHEN "AYAH"."Nama_depan" = "ORANG"."Nama_depan" THEN NULL ELSE "AYAH"."Nama_depan" END AS "Nama_depan_ayah",
    "IBU"."Nama_depan" AS "Nama_depan_ibu"
FROM "ORANG"
JOIN "KELAHIRAN" ON "ORANG"."Id_orang" = "KELAHIRAN"."Id_orang"
JOIN "ALAMAT" ON "KELAHIRAN"."Id_tempat" = "ALAMAT"."Id_alamat"
JOIN "KOTA" AS "TEMPATL" ON "TEMPATL"."Id_kota" = "ALAMAT"."Id_kota"
JOIN "KELUARGA" ON "KELUARGA"."Id_KK" = "ORANG"."Id_KK" 
LEFT JOIN "ORANG" AS "AYAH" ON "KELUARGA"."Id_kepala_keluarga" = "AYAH"."Id_orang"
LEFT JOIN "PERNIKAHAN" ON "PERNIKAHAN"."Id_pria" = "AYAH"."Id_orang"
LEFT JOIN "ORANG" AS "IBU" ON "IBU"."Id_orang" = "PERNIKAHAN"."id_wanita"
WHERE 
    ("AYAH"."Id_orang" != "ORANG"."Id_orang" OR "IBU"."Id_orang" != "ORANG"."Id_orang")
    OR ("AYAH"."Id_orang" IS NULL OR "IBU"."Id_orang" IS NULL)
ORDER BY "KELAHIRAN"."Id_akta" ASC


-- migrasi antar daerah

SELECT
	"MIGRASI"."Id_migrasi", "Nama_depan", "Nama_tengah", "Nama_belakang",
	"MIGRASI"."Status", "MIGRASI"."Tanggal", "MIGRASI_ANTAR_DAERAH"."alasan_migrasi", 
	"Kota_asal"."Nama_kota", "Kota_tujuan"."Nama_kota"
FROM "MIGRASI"
JOIN "MIGRASI_ANTAR_DAERAH" ON "MIGRASI"."Id_migrasi" = "MIGRASI_ANTAR_DAERAH"."id_migrasi"
JOIN "melakukan_migrasi" ON "MIGRASI"."Id_migrasi" = "melakukan_migrasi"."Id_migrasi"
JOIN "ORANG" ON "melakukan_migrasi"."id_orang" = "ORANG"."Id_orang"
JOIN "KOTA" AS "Kota_asal" ON "MIGRASI_ANTAR_DAERAH"."id_kota_asal" = "Kota_asal"."Id_kota" 
JOIN "KOTA" AS "Kota_tujuan" ON "MIGRASI_ANTAR_DAERAH"."id_kota_tujuan" = "Kota_tujuan"."Id_kota" 

-- imigrasi


SELECT
	"MIGRASI"."Id_migrasi", "Nama_depan", "Nama_tengah", "Nama_belakang",
	"MIGRASI"."Status", "MIGRASI"."Tanggal", "IMIGRASI"."Alasan_migrasi", 
	"NEGARA"."Nama_negara", "Kota_tujuan"."Nama_kota"
FROM "MIGRASI"
JOIN "IMIGRASI" ON "MIGRASI"."Id_migrasi" = "IMIGRASI"."Id_migrasi"
JOIN "melakukan_migrasi" ON "MIGRASI"."Id_migrasi" = "melakukan_migrasi"."Id_migrasi"
JOIN "ORANG" ON "melakukan_migrasi"."id_orang" = "ORANG"."Id_orang"
JOIN "KOTA" AS "Kota_tujuan" ON "IMIGRASI"."Id_kota" = "Kota_tujuan"."Id_kota" 
JOIN "NEGARA" ON "IMIGRASI"."Id_negara" = "NEGARA"."Id_negara"

-- imigrasi sql
SELECT
	"MIGRASI"."Id_migrasi", "Nama_depan", "Nama_tengah", "Nama_belakang",
	"MIGRASI"."Status", "MIGRASI"."Tanggal", "IMIGRASI"."Alasan_imigrasi", 
	"NEGARA"."Nama_negara", "Kota_tujuan"."Nama_kota"
FROM "MIGRASI"
JOIN "IMIGRASI" ON "MIGRASI"."Id_migrasi" = "IMIGRASI"."Id_migrasi"
JOIN "melakukan_migrasi" ON "MIGRASI"."Id_migrasi" = "melakukan_migrasi"."Id_migrasi"
JOIN "ORANG" ON "melakukan_migrasi"."id_orang" = "ORANG"."Id_orang"
JOIN "KOTA" AS "Kota_tujuan" ON "IMIGRASI"."Id_kota" = "Kota_tujuan"."Id_kota" 
JOIN "NEGARA" ON "IMIGRASI"."Id_negara" = "NEGARA"."Id_negara"

-- pajak

SELECT
	"Id_npwp_tahun", "Jumlah_pajak_total", "Tahun", "Status", 
	"ORANG"."Nama_depan", "ORANG"."Nama_tengah", "ORANG"."Nama_belakang"
FROM "PAJAK"
JOIN "ORANG" ON "ORANG"."Id_orang" = "PAJAK"."Id_orang"

-- penduduk

select *, "PEKERJAAN"."Nama_pekerjaan", "KOTA"."Nama_kota" from "ORANG"
JOIN "PENDUDUK" ON "ORANG"."Id_orang" = "PENDUDUK"."Id_orang"
JOIN "PEKERJAAN" ON "ORANG"."Id_pekerjaan" = "PEKERJAAN"."Id_pekerjaan"
JOIN "KOTA" ON "ORANG"."Id_kota_domisili" = "KOTA"."Id_kota"

-- penduduk sql

select *, "PEKERJAAN"."Nama_pekerjaan", "KOTA"."Nama_kota" from "ORANG"
JOIN "PENDUDUK" ON "ORANG"."Id_orang" = "PENDUDUK"."Id_orang"
JOIN "PEKERJAAN" ON "ORANG"."Id_pekerjaan" = "PEKERJAAN"."Id_pekerjaan"
JOIN "KOTA" ON "ORANG"."Id_kota" = "KOTA"."Id_kota"

-- jumlah perempuan wna penghasilan di atas rata" penghasilan wni, sudah menikah, punya anak 1

SELECT *
FROM "ORANG" AS "O"
JOIN "IMIGRAN" AS "I" ON "O"."Id_orang" = "I"."Id_orang"
JOIN "KEUANGAN" AS "K" ON "O"."Id_orang" = "K"."Id_orang"
WHERE "O"."Jenis_kelamin" = 'P' AND "K"."Pendapatan" > (
    SELECT AVG(Pendapatan) AS Average_Income
    FROM KEUANGAN k
    INNER JOIN ORANG o ON k.Id_orang = o.Id_orang
    INNER JOIN PENDUDUK p ON o.Id_orang = p.Id_orang
);

SELECT O.Id_orang, O.Nama_depan, O.Nama_tengah, O.Nama_belakang,
       P.Nama_pekerjaan,
       PX.Jumlah_pajak_total
FROM ORANG O
JOIN PEKERJAAN P ON O.Id_pekerjaan = P.Id_pekerjaan
JOIN PAJAK P ON O.Id_orang = P.Id_orang;

-- daftar orang dan pekerjaan serta pajaknya
-- data wna yg meninggal di indo, menikah dgn wni, memiliki anak dg pendidikan s3
-- kecamatan terpadat ditiap provinsi dengan angka kelahiran dari Ibu muda dibawah 17th
-- ga ada ditambahin, atu tidak pling mendekati

SELECT *
FROM ORANG O
JOIN IMIGRAN I ON I.Id_orang = O.Id_orang
JOIN MENEMPUH_PENDIDIKAN MP ON MP.Id_orang = O.Id_orang
JOIN PENDIDIKAN P ON P.Id_instansi = MP.Id_instansi
JOIN PERNIKAHAN PER ON PER.Id_wanita = I.Id_orang
JOIN PENDUDUK PEN ON PEN.Id_orang = PER.Id_pria
JOIN KEMATIAN KEM ON KEM.Id_orang = I.Id_orang
JOIN KELUARGA K ON K.Id_kepala_keluarga = PEN.Id_orang
JOIN ORANG A ON A.Id_KK = K.Id_KK 

SELECT Id_akta, A.kecamatan
FROM KELAHIRAN K
JOIN ALAMAT A ON A.Id_alamat = K.Id_tempat
JOIN ORANG O ON O.Id_orang = K.Id_orang
JOIN KELUARGA KEL ON KEL.Id_KK = O.Id_KK
JOIN ORANG O2 ON O2.Id_orang = KEL.Id_kepala_keluarga
JOIN PERNIKAHAN PER ON PER.Id_pria = O2.Id_orang
JOIN ORANG IBU ON IBU.Id_orang = PER.Id_wanita
WHERE DATEDIFF(year, IBU.Tanggal_lahir, 2023) < 18


-- new

SELECT x.Provinsi, x.Kecamatan, x.Jumlah_Penduduk, 
    (SELECT COUNT(*)
    FROM PERNIKAHAN p
    INNER JOIN ORANG ibu ON p.Id_wanita = ibu.Id_orang
    INNER JOIN KELAHIRAN k ON k.Id_orang = ibu.Id_orang
    WHERE YEAR(k.Tanggal) - YEAR(ibu.Tanggal_Lahir) < 17 AND  
          k.Id_tempat IN (SELECT Id_alamat 
            FROM ALAMAT 
            WHERE Kecamatan = x.Kecamatan)) AS Jumlah_Kelahiran_Ibu_Muda
FROM
(
  SELECT a.Provinsi, a.Kecamatan, a.Jumlah_Penduduk
  FROM
  (
    SELECT a.Provinsi, a.Kecamatan, COUNT(o.Id_orang) AS Jumlah_Penduduk 
    FROM ALAMAT a
    LEFT JOIN KELUARGA k ON a.Id_alamat = k.Id_alamat
    LEFT JOIN ORANG o ON k.Id_KK = o.Id_KK OR (o.Id_kota IS NOT NULL AND o.Id_kota = a.Id_kota)
    GROUP BY a.Provinsi, a.Kecamatan
  ) a
  INNER JOIN
  (
    SELECT Provinsi, MAX(Jumlah_Penduduk) AS Jumlah_Penduduk
    FROM
    (
      SELECT a.Provinsi, COUNT(o.Id_orang) AS Jumlah_Penduduk
      FROM ALAMAT a
      LEFT JOIN KELUARGA k ON a.Id_alamat = k.Id_alamat
      LEFT JOIN ORANG o ON k.Id_KK = o.Id_KK OR (o.Id_kota IS NOT NULL AND o.Id_kota = a.Id_kota)
      GROUP BY a.Provinsi
    ) x  
    GROUP BY Provinsi
  ) b
  ON a.Provinsi = b.Provinsi AND a.Jumlah_Penduduk = b.Jumlah_Penduduk
) x
