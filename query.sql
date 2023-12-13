SELECT *
FROM 
	ORANG O
JOIN PEKERJAAN P ON O.Id_pekerjaan = P.Id_pekerjaan
WHERE P.[Nama_pekerjaan] = 'Pemrogram';