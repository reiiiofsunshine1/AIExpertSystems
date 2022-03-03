; ----------------------
; datas used in this code was extracted from:
; https://www.kaggle.com/iancornish/drug-data
; ----------------------

(defrule questions1
    =>
    (printout t crlf "Masukkan '1' apabila jawaban anda 'iya' dan '2' jika jawaban anda tidak" crlf)
    (printout t crlf "Apakah anda sedang mengalami keluhan kesehatan?" crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (assert (questions1 yes))
        then (assert (check_checkup))
    )
    (if (= ?x 2)
        then (assert (questions1 no))
        then (assert (check_supplements))
    )
)

(defrule checkup
    (check_checkup)
    =>
    (printout t crlf "Sudahkah anda melakukan pemeriksaan ke dokter anda?"crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (assert (checkup yes))
        then (assert (check_disease))
    )
    (if (= ?x 2)
        then (assert (checkup no))
        then (assert (check_doctor))
    )
)

(defrule supplements
    (check_supplements)
    =>
    (printout t crlf "Apakah anda sedang/sudah mengonsumsi suplemen harian?" crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (assert (supplements yes))
        then (assert (check_wish))
    )
    (if (= ?x 2)
        then (assert (supplements no))
        then (assert (check_vitamin))
    )
)

(defrule wish
    (check_wish)
    =>
    (printout t crlf "Tetap konsumsi suplemen vitamin anda sesuai anjuran dokter. Sehat selalu!" crlf)
)

(defrule vitamin
    (check_vitamin)
    =>
    (printout t crlf "Berikut adalah rekomendasi suplemen dan vitamin dari kami:" crlf)
    (printout t crlf "Vitamin D, vitamin C, vitamin E")
    then (assert (wish))
)

(defrule doctor
    (check_doctor)
    =>
    (printout t crlf "Segeralah pergi ke dokter anda untuk melakukan pemeriksaan kesehatan!" crlf)
)

(defrule disease
    (check_disease)
    =>
    (printout t crlf "Apakah penyakit yang didiagnosa oleh dokter anda termasuk dari salah satu penyakit dibawah?" crlf)
    (printout t crlf "
        1.  Batuk/pilek
	2. 	Penyakit lain" crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (assert (disease yes))
        then (assert (check_yesdata))
    )
    (if (= ?x 2)
        then (assert (disease no))
        then (assert (check_notyet))
    )
)

(defrule yesdata
    (check_yesdata)
    =>
    (printout t crlf "Pilihlah penyakit anda sesuai dengan nomor urutannya." crlf)
    (printout t crlf "
        1.  Batuk/Pilek
        0. Penyakit lain" crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (assert (check_coughtype))
    )
    (if (= ?x 0)
        then (assert (check_notyet))
    )
) 

(defrule notyet
    (check_notyet)
    =>
    (printout t crlf "Maaf. Obat untuk penyakit anda belum terdaftar di database kami." crlf)
    (printout t crlf "Mintalah resep obat pada dokter anda. Semoga lekas sembuh!" crlf)
)

(defrule coughtype
    (check_coughtype)
    =>
    (printout t crlf "Apakah batuk anda berdahak? Atau kering?" crlf)
    (printout t crlf "Pilih '1' untuk berdahak dan '2' untuk kering." crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (assert (coughtype yes))
        then (assert (check_coughage))
    )
    (if (= ?x 2)
        then (assert (coughtype no))
        then (assert (check_coughage))
    )
)
(defrule coughage
    (check_coughage)
    =>
    (printout t crlf "Apakah anda berumur di atas 12 tahun?" crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (assert (coughage yes))
        then (assert (check_drugrec))
    )
    (if (= ?x 2)
        then (assert (coughage no))
        then (assert (check_drugrec))
    )
)

(defrule drugrec
    (check_drugrec)
    =>
    (printout t crlf "Apakah anda ingin rekomendasi obat dari kami?" crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (assert (drugrec yes))
    )
    (if (= ?x 2)
        then (assert (drugrec no))
        then (assert (check_nodrugrec))
    )
)

(defrule check_cough12updahak
    (coughtype yes)
    (coughage yes)
    (drugrec yes)
    =>
    (printout t crlf "Anda adalah orang dewasa dengan gejala batuk berdahak. Berikut adalah obat rekomendasi dari kami: " crlf)
    (printout t crlf "
    1. Mucos Drops: 
    Obat batuk sirup ini mengandung bahan aktif Ambroxol. Kandungan tersebut berguna untuk mengencerkan dahak 
    atau lendir pada saluran pernapasan sehingga lendir mudah dikeluarkan dari saluran pernapasan.
    2. Bodrex Flu & Batuk Berdahak
    Obat ini mengandung Bromhexine Hcl, Guaifenesin, Phenylephrine HCL, dan Paracetamol.
    Tidak hanya mengobati batuk berdahak, obat ini juga dapat meredakan gejala flu seperti sakit kepala, demam, bersin-bersin, dan hidung tersumbat." crlf)
)

(defrule cough12downdahak
    (coughtype yes)
    (coughage no)
    (drugrec yes)
    =>
    (printout t crlf "Anda adalah anak dengan gejala batuk berdahak. Berikut adalah obat rekomendasi dari kami: " crlf)
    (printout t crlf "Obat Batuk Bisolvon Kids:
    Obat batuk pengencer dahak anak ini memiliki rasa stroberi yang bebas gula dan berbentuk sirup. 
    Obat ini mengandung bahan Bromhexine yang dapat bekerja dengan cara mengencerkan dahak di saluran pernapasan.
    ")
)

(defrule cough12upkering
    (coughtype no)
    (coughage yes)
    (drugrec yes)
    =>
    (printout t crlf "Anda adalah orang dewasa dengan gejala batuk kering. Berikut adalah obat rekomendasi dari kami: " crlf)
    (printout t crlf "
        1. Siladex Antitussive:
    Siladex Antitussive adalah obat batuk yang diformulasikan khusus untuk mengatasi masalah batuk tidak berdahak atau kering. 
    Obat ini memiliki kandungan guaifenesin 50 mg dan bromhexine HCl 10 mg.
    2. Sanadryl Dmp Sirup:
    Sanadryl Dmp Sirup adalah obat batuk cair untuk mengobati sakit batuk kering akibat alergi. 
    Obat ini mengandung bahan aktif dextrometorfan Hbr yang efektif dalam meredakan batuk.
    " crlf)
)

(defrule cough12downkering
    (coughtype no)
    (coughage no)
    (drugrec yes)
    =>
    (printout t crlf "Anda adalah anak dengan gejala batuk kering. Berikut adalah obat rekomendasi dari kami: " crlf)
    (printout t crlf "Ikadryl Syrup Apel:
    Obat sirup dengan rasa apel ini aman digunakan untuk orang dewasa dan anak-anak usia 10 tahun ke atas. " crlf)
)

(defrule nodrugrec
    (questions1 no)
    (drugrec no)
    =>
    (printout t crlf "Jangan lupa segera periksakan keluhan anda ke dokter anda atau mencari obat sendiri. Semoga lekas sembuh!" crlf)
)
