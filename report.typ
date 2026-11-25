#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
  footer: context[
    #set text(
      size: 11pt,
      fill: luma(100),
    )

    Mythos 5 #h(1fr)
    _Laporan Proyek SIPAKA_ #h(8pt)
    #box(
      width: 1.75em,
      height: 1.75em,
      fill: luma(240),
      baseline: 30%,
      [
        #set text(fill: black)
        #align(center + horizon, counter(page).display())
      ],
    )
  ]
)

#set text(
  font: "Inter",
  size: 12pt,
  fill: luma(30),
  lang: "id",
  hyphenate: true,
)

#set par(
  spacing: 1.35em,
  leading: 0.75em,
  justify: true,
)

#set heading(numbering: "1.1.")
#show heading: set text(fill: black)
#show heading: set block(above: 1.75em, below: 1.2em)
#show heading.where(level: 1): set block(above: 1.5em, below: 1em)
#show heading.where(level: 1): set text(size: 16pt)
#show heading.where(level: 1): it => {
  for kind in query(figure).map(f => f.kind).dedup() {
    counter(figure.where(kind: kind)).update(0)
  }
  it
}

#set figure(
  gap: 1em,
  numbering: (..nums) => {
    let h = counter(heading).get().first()
    numbering("1.1", h, ..nums)
  }
)
#show figure.caption: it => [
  #set text(size: 0.9em)
  #it.supplement #it.counter.display(it.numbering). #it.body
]

// =============================================================================

#block[
  #set text(size: 24pt, weight: 800)
  Laporan Proyek SIPAKA
]
#block(above: 1.1em, below: 2em)[
  #set text(size: 0.9em, weight: 300, fill: luma(75))
  Sistem Informasi Pelacakan Amandemen, Kodifikasi, dan Advokasi
]

Disusun oleh kelompok Mythos 5:

- Arya Eki Nur Seputro (160425152)
- Jovan Abel Mulyanto (160425011)
- Jevon Aldrich Halim (160425078)
- Imanelient Arkan (160425104)
- Ardhie Nurdianto (160425113)

= Struktur Modul

Struktur modul proyek kami dibagi menjadi 8 bagian utama, yakni _Kelola Akun & Akses_, _Pelacak Dokumen Hukum_, _Kelola Konten Hukum_, _Forum Diskusi Kasus_, _Kelola Profil_, _Kelola Repositori_, _Glosarium Latin_, dan _Asisten Riset AI_.

#figure(
  image("module/00_sipaka.svg", width: 100%),
  caption: [Struktur modul utama SIPAKA.],
  supplement: "Gambar",
)

Modul-modul tersebut disusun berdasarkan kategori konten yang dikelola dan menggambarkan proses-proses pada aplikasi SIPAKA secara umum dan dari segi sistem.
Peran dari masing-masing modul dijelaskan di bagian berikutnya.

Untuk membantu pembacaan struktur modul di bawah, kami menetapkan beberapa istilah dan penanda visual.
_Modul_ merujuk pada modul utama, yakni 8 bagian yang berada di paling atas (level satu).
_Submodul_ merupakan turunan dari modul dan submodul yang lebih tinggi darinya.
Berikut merupakan keterangan dari tanda visual pada setiap elemen yang digunakan:

- Kotak berwarna *putih* melambangkan deklarasi modul/submodul biasa.
- Kotak berwarna *biru* melambangkan dependensi terhadap submodul yang dideklarasikan di modul yang _sama_.
- Kotak berwarna *merah* melambangkan dependensi terhadap submodul yang dideklarasikan di modul yang _berbeda_.

#page(flipped: true)[
  == Kelola Akun & Akses

  Modul _Kelola Akun & Akses_ mengatur autentikasi dan otorisasi pengguna aplikasi.
  Modul ini terdiri dari 5 submodul utama, yakni _Daftar Akun_, _Masuk ke Akun_, _Keluar dari Akun_, _Otorisasi Akses_, dan _Kelola Peran Pengguna_:

  - Ketiga submodul pertama mencakupi pembuatan akun, proses autentikasi, dan pengelolaan sesi pengguna.
  - Submodul _Otorisasi Akses_ melakukan validasi terhadap sesi serta peran pengguna sebelum mengakses konten tertentu.
  - Submodul _Kelola Peran_ Pengguna melakukan modifikasi terhadap peran pengguna.

  Submodul _Otorisasi Akses_ akan sering digunakan di modul lain karena fungsinya sebagai _middleware_.
  Contoh, panel forum diskusi dan repositori membutuhkan pengguna untuk memiliki sesi yang valid (_logged in_).

  #figure(
    image("module/01_kelola_akun_akses.svg", width: 100%),
    caption: [Struktur modul Kelola Akun & Akses.],
    supplement: "Gambar",
  )

  #pagebreak(weak: true)
  == Pelacak Dokumen Hukum

  Modul _Pelacak Dokumen Hukum_ berfungsi untuk membantu pengguna mencari, membaca, dan melacak perubahan dokumen undang-undang.
  Modul ini terdiri dari 5 submodul utama, yakni _Cari Undang-Undang_, _Lihat Detail Undang-Undang_, _Baca Teks Undang-Undang_, _Lacak Amandemen_, dan _Anotasi Teks Undang-Undang_:

  - Submodul _Cari Undang-Undang_ menangani pencarian dokumen undang-undang berdasarkan kueri, filter, dan urutan hasil pencarian.
  - Submodul _Lihat Detail Undang-Undang_ menampilkan metadata, status keberlakuan, serta menyediakan akses untuk mengunduh dokumen PDF asli.
  - Submodul _Baca Teks Undang-Undang_ menampilkan teks konsolidasi, menyediakan navigasi struktur dokumen, serta mendeteksi dan menampilkan istilah Latin.
  - Submodul _Lacak Amandemen_ menampilkan linimasa amandemen, menandai perubahan teks, membandingkan versi pasal, serta memvisualisasikan relasi antarundang-undang.
  - Submodul _Anotasi Teks Undang-Undang_ mengelola anotasi pada teks undang-undang, termasuk pembuatan, pengubahan, penghapusan, dan pemberian penanda pasal.

  #figure(
    image("module/02_pelacak_dokumen_hukum.svg", width: 100%),
    caption: [Struktur modul Pelacak Dokumen Hukum.],
    supplement: "Gambar",
  )

  #pagebreak(weak: true)
  == Kelola Konten Hukum

  Modul _Kelola Konten Hukum_ berfungsi untuk mengelola dokumen undang-undang beserta informasi dan riwayat perubahannya.
  Modul ini terdiri dari 4 submodul utama, yakni _Impor Dokumen UU_, _Daftarkan Amandemen_, _Ubah Metadata UU_, dan _Hapus Dokumen UU_:

  - Submodul _Impor Dokumen UU_ menangani penguraian PDF, ekstraksi struktur dokumen, validasi metadata, dan penerbitan dokumen undang-undang.
  - Submodul _Daftarkan Amandemen_ mengelola pendaftaran perubahan undang-undang, mulai dari penautan undang-undang pengubah hingga penyusunan teks konsolidasi dan pembaruan status keberlakuan.
  - Submodul _Ubah Metadata UU_ melakukan perubahan terhadap metadata dokumen undang-undang.
  - Submodul _Hapus Dokumen UU_ menangani penghapusan dokumen undang-undang dari sistem.

  #figure(
    image("module/03_kelola_konten_hukum.svg", width: 80%),
    caption: [Struktur modul Kelola Konten Hukum.],
    supplement: "Gambar",
  )

  #pagebreak(weak: true)
  == Forum Diskusi Kasus

  Modul _Forum Diskusi Kasus_ menyediakan ruang bagi pengguna untuk berdiskusi, berbagi analisis, dan memverifikasi argumen hukum.
  Modul ini terdiri dari 8 submodul utama, yakni _Jelajahi Diskusi_, _Buat Thread Diskusi_, _Lihat Thread Diskusi_, _Kirim Komentar_, _Upvote Komentar_, _Verifikasi Argumen_, dan _Moderasi Konten_:

  - Submodul _Jelajahi Diskusi_ menampilkan daftar diskusi berdasarkan kategori hukum yang dipilih.
  - Submodul _Buat Thread Diskusi_ menangani pembuatan thread diskusi, termasuk validasi isi, pemilihan tipe thread, penetapan kategori hukum, dan penautan rujukan undang-undang.
  - Submodul _Lihat Thread Diskusi_ menampilkan isi thread, mengurutkan komentar, menampilkan lencana verifikasi, serta mendeteksi istilah Latin.
  - Submodul _Kirim Komentar_ menangani pengiriman komentar dengan melakukan validasi terhadap isi komentar.
  - Submodul _Upvote Komentar_ mengelola status upvote pada komentar.
  - Submodul _Verifikasi Argumen_ melakukan peninjauan dan penandaan terhadap argumen hukum yang telah diverifikasi, serta memberikan lencana verifikasi.
  - Submodul _Moderasi Konten_ menangani pelaporan, peninjauan, dan penghapusan konten yang dilaporkan.

  #figure(
    image("module/04_forum_diskusi_kasus.svg", width: 100%),
    caption: [Struktur modul Forum Diskusi Kasus.],
    supplement: "Gambar",
  )

  #pagebreak(weak: true)
  == Kelola Profil

  Modul _Kelola Profil_ mengatur informasi profil dan reputasi pengguna dalam aplikasi.
  Modul ini terdiri dari 3 submodul utama, yakni _Lihat Profil_, _Ubah Profil_, dan _Kelola Reputasi_:

  - Submodul _Lihat Profil_ menampilkan informasi reputasi pengguna, lencana yang diperoleh, serta riwayat aktivitas dalam forum diskusi.
  - Submodul _Ubah Profil_ menangani perubahan informasi profil pengguna.
  - Submodul _Kelola Reputasi_ mengelola pemberian poin reputasi berdasarkan aktivitas pengguna serta mengevaluasi kelayakan pengguna untuk memperoleh lencana prestasi.

  #figure(
    image("module/05_kelola_profil.svg", width: 75%),
    caption: [Struktur modul Kelola Profil.],
    supplement: "Gambar",
  )

  #pagebreak(weak: true)
  == Kelola Repositori

  Modul _Kelola Repositori_ berfungsi untuk mengelola kumpulan studi kasus dan analisis hukum yang disimpan dalam aplikasi.
  Modul ini terdiri dari 5 submodul utama, yakni _Tambah Entri Repositori_, _Jelajahi Repositori_, _Ubah Entri Repositori_, _Hapus Entri Repositori_, dan _Atur Visibilitas Entri_:

  - Submodul _Tambah Entri Repositori_ menangani penambahan entri baru berupa studi kasus, catatan pasal, dan analisis hukum.
  - Submodul _Jelajahi Repositori_ menampilkan entri repositori berdasarkan filter yang diterapkan.
  - Submodul _Ubah Entri Repositori_ menangani perubahan informasi pada entri repositori.
  - Submodul _Hapus Entri Repositori_ menangani penghapusan entri repositori.
  - Submodul _Atur Visibilitas Entri_ mengatur tingkat visibilitas entri repositori.

  #figure(
    image("module/06_kelola_repositori.svg", width: 100%),
    caption: [Struktur modul Kelola Repositori.],
    supplement: "Gambar",
  )

  #pagebreak(weak: true)
  == Glosarium Latin

  Modul _Glosarium Latin_ berfungsi untuk membantu pengguna memahami istilah-istilah Latin yang ditemukan dalam dokumen hukum maupun diskusi.
  Modul ini terdiri dari 3 submodul utama, yakni _Deteksi Istilah Latin_, _Tampilkan Popup Istilah_, dan _Kelola Glosarium_:

  - Submodul _Deteksi Istilah Latin_ memindai teks untuk menemukan istilah yang terdaftar dalam glosarium dan memberikan penanda pada istilah tersebut.
  - Submodul _Tampilkan Popup Istilah_ mencari definisi istilah Latin dan menyusunnya dalam bentuk popup agar dapat ditampilkan kepada pengguna.
  - Submodul _Kelola Glosarium_ menangani penambahan, pengubahan, dan penghapusan istilah dalam glosarium.

  #figure(
    image("module/07_glosarium_latin.svg", width: 100%),
    caption: [Struktur modul Glosarium Latin.],
    supplement: "Gambar",
  )

  #pagebreak(weak: true)
  == Asisten Riset AI

  Modul _Asisten Riset AI_ menyediakan fitur berbasis kecerdasan buatan untuk membantu pengguna melakukan pencarian dan analisis informasi hukum.
  Modul ini terdiri dari 5 submodul utama, yakni _Tangani Permintaan AI_, _Jelaskan Undang-Undang_, _Cari dengan AI_, _Temukan Kasus Serupa_, dan _Laporkan Jawaban AI Keliru_:

  - Submodul _Tangani Permintaan AI_ mengelola pemrosesan permintaan pengguna, termasuk pemeriksaan kuota penggunaan, pengambilan respons dari cache, penyusunan prompt konteks, penyimpanan respons ke cache, dan penyertaan disclaimer AI.
  - Submodul _Jelaskan Undang-Undang_ membantu pengguna memahami makna pasal dan memperoleh ringkasan linimasa amandemen.
  - Submodul _Cari dengan AI_ menangani pencarian berbasis kecerdasan buatan dengan menafsirkan kueri pengguna, mengurutkan hasil, dan menerapkan filter pencarian.
  - Submodul _Temukan Kasus Serupa_ mencari kasus yang memiliki kemiripan berdasarkan fakta kasus, menampilkan kasus paralel, serta menyajikan riwayat penanganan kasus.
  - Submodul _Laporkan Jawaban AI Keliru_ menyediakan mekanisme pelaporan kesalahan jawaban AI agar jawaban tersebut dapat ditandai untuk ditinjau.

  #figure(
    image("module/08_asisten_riset_ai.svg", width: 100%),
    caption: [Struktur modul Asisten Riset AI.],
    supplement: "Gambar",
  )
]

#pagebreak()

#page(flipped: true)[
  #set figure(gap: 0em)

  = _Business Process Model and Notation_ (BPMN)

  == Kelola Akun & Akses

  === Daftarkan Akun

  #figure(
    image("bpmn/01_kelola_akun_akses/01_daftarkan_akun.svg"),
    caption: [Alur BPMN untuk proses _Daftarkan Akun_.],
    supplement: "Gambar",
  )

  === Masuk

  #figure(
    image("bpmn/01_kelola_akun_akses/02_masuk.svg"),
    caption: [Alur BPMN untuk proses _Masuk_.],
    supplement: "Gambar",
  )

  === Keluar

  #figure(
    image("bpmn/01_kelola_akun_akses/03_keluar.svg"),
    caption: [Alur BPMN untuk proses _Keluar_.],
    supplement: "Gambar",
  )

  === Otorisasi Akses

  #figure(
    image("bpmn/01_kelola_akun_akses/04_otorisasi_akses.svg"),
    caption: [Alur BPMN untuk proses _Otorisasi Akses_.],
    supplement: "Gambar",
  )

  === Kelola Peran Pengguna

  #figure(
    image("bpmn/01_kelola_akun_akses/05_kelola_peran_pengguna.svg"),
    caption: [Alur BPMN untuk proses _Kelola Peran Pengguna_.],
    supplement: "Gambar",
  )

  == Pelacak Dokumen Hukum

  === Cari Undang-Undang

  #figure(
    image("bpmn/02_pelacak_dokumen_hukum/06_cari_undang_undang.svg"),
    caption: [Alur BPMN untuk proses _Cari Undang-Undang_.],
    supplement: "Gambar",
  )

  === Lihat Detail Undang-Undang

  #figure(
    image("bpmn/02_pelacak_dokumen_hukum/07_lihat_detail_undang_undang.svg"),
    caption: [Alur BPMN untuk proses _Lihat Detail Undang-Undang_.],
    supplement: "Gambar",
  )

  === Baca Teks Undang-Undang

  #figure(
    image("bpmn/02_pelacak_dokumen_hukum/08_baca_teks_undang_undang.svg"),
    caption: [Alur BPMN untuk proses _Baca Teks Undang-Undang_.],
    supplement: "Gambar",
  )

  === Lacak Amandemen

  #figure(
    image("bpmn/02_pelacak_dokumen_hukum/09_lacak_amandemen.svg"),
    caption: [Alur BPMN untuk proses _Lacak Amandemen_.],
    supplement: "Gambar",
  )

  === Anotasi Teks Undang-Undang

  #figure(
    image("bpmn/02_pelacak_dokumen_hukum/10_anotasi_teks_undang_undang.svg"),
    caption: [Alur BPMN untuk proses _Anotasi Teks Undang-Undang_.],
    supplement: "Gambar",
  )

  == Kelola Konten Hukum

  === Impor Dokumen UU

  #figure(
    image("bpmn/03_kelola_konten_hukum/11_impor_dokumen_uu.svg"),
    caption: [Alur BPMN untuk proses _Impor Dokumen UU_.],
    supplement: "Gambar",
  )

  === Daftarkan Amandemen

  #figure(
    image("bpmn/03_kelola_konten_hukum/12_daftarkan_amandemen.svg"),
    caption: [Alur BPMN untuk proses _Daftarkan Amandemen_.],
    supplement: "Gambar",
  )

  === Ubah Metadata UU

  #figure(
    image("bpmn/03_kelola_konten_hukum/13_ubah_metadata_uu.svg"),
    caption: [Alur BPMN untuk proses _Ubah Metadata UU_.],
    supplement: "Gambar",
  )

  === Hapus Dokumen UU

  #figure(
    image("bpmn/03_kelola_konten_hukum/14_hapus_dokumen_uu.svg"),
    caption: [Alur BPMN untuk proses _Hapus Dokumen UU_.],
    supplement: "Gambar",
  )

  == Forum Diskusi Kasus

  === Jelajahi Diskusi

  #figure(
    image("bpmn/04_forum_diskusi_kasus/15_jelajahi_diskusi.svg"),
    caption: [Alur BPMN untuk proses _Jelajahi Diskusi_.],
    supplement: "Gambar",
  )

  === Buat _Thread_ Diskusi

  #figure(
    image("bpmn/04_forum_diskusi_kasus/16_buat_thread_diskusi.svg"),
    caption: [Alur BPMN untuk proses _Buat _Thread_ Diskusi_.],
    supplement: "Gambar",
  )

  === Lihat _Thread_ Diskusi

  #figure(
    image("bpmn/04_forum_diskusi_kasus/17_lihat_thread_diskusi.svg"),
    caption: [Alur BPMN untuk proses _Lihat _Thread_ Diskusi_.],
    supplement: "Gambar",
  )

  === Kirim Komentar

  #figure(
    image("bpmn/04_forum_diskusi_kasus/18_kirim_komentar.svg"),
    caption: [Alur BPMN untuk proses _Kirim Komentar_.],
    supplement: "Gambar",
  )

  === Upvote Komentar

  #figure(
    image("bpmn/04_forum_diskusi_kasus/19_upvote_komentar.svg"),
    caption: [Alur BPMN untuk proses _Upvote Komentar_.],
    supplement: "Gambar",
  )

  === Verifikasi Argumen

  #figure(
    image("bpmn/04_forum_diskusi_kasus/20_verifikasi_argumen.svg"),
    caption: [Alur BPMN untuk proses _Verifikasi Argumen_.],
    supplement: "Gambar",
  )

  === Moderasi Konten

  #figure(
    image("bpmn/04_forum_diskusi_kasus/21_moderasi_konten.svg"),
    caption: [Alur BPMN untuk proses _Moderasi Konten_.],
    supplement: "Gambar",
  )

  == Kelola Profil

  === Lihat Profil

  #figure(
    image("bpmn/05_kelola_profil/22_lihat_profil.svg"),
    caption: [Alur BPMN untuk proses _Lihat Profil_.],
    supplement: "Gambar",
  )

  === Ubah Profil

  #figure(
    image("bpmn/05_kelola_profil/23_ubah_profil.svg"),
    caption: [Alur BPMN untuk proses _Ubah Profil_.],
    supplement: "Gambar",
  )

  === Kelola Reputasi

  #figure(
    image("bpmn/05_kelola_profil/24_kelola_reputasi.svg"),
    caption: [Alur BPMN untuk proses _Kelola Reputasi_.],
    supplement: "Gambar",
  )

  == Kelola Repositori

  === Tambah Entri Repositori

  #figure(
    image("bpmn/06_kelola_repositori/25_tambah_entri_repositori.svg"),
    caption: [Alur BPMN untuk proses _Tambah Entri Repositori_.],
    supplement: "Gambar",
  )

  === Jelajahi Repositori

  #figure(
    image("bpmn/06_kelola_repositori/26_jelajahi_repositori.svg"),
    caption: [Alur BPMN untuk proses _Jelajahi Repositori_.],
    supplement: "Gambar",
  )

  === Ubah Entri Repositori

  #figure(
    image("bpmn/06_kelola_repositori/27_ubah_entri_repositori.svg"),
    caption: [Alur BPMN untuk proses _Ubah Entri Repositori_.],
    supplement: "Gambar",
  )

  === Hapus Entri Repositori

  #figure(
    image("bpmn/06_kelola_repositori/28_hapus_entri_repositori.svg"),
    caption: [Alur BPMN untuk proses _Hapus Entri Repositori_.],
    supplement: "Gambar",
  )

  === Atur Visibilitas Entri

  #figure(
    image("bpmn/06_kelola_repositori/29_atur_visibilitas_entri.svg"),
    caption: [Alur BPMN untuk proses _Atur Visibilitas Entri_.],
    supplement: "Gambar",
  )

  == Glosarium Latin

  === Deteksi Istilah Latin

  #figure(
    image("bpmn/07_glosarium_latin/30_deteksi_istilah_latin.svg"),
    caption: [Alur BPMN untuk proses _Deteksi Istilah Latin_.],
    supplement: "Gambar",
  )

  === Tampilkan Popup Istilah

  #figure(
    image("bpmn/07_glosarium_latin/31_tampilkan_popup_istilah.svg"),
    caption: [Alur BPMN untuk proses _Tampilkan Popup Istilah_.],
    supplement: "Gambar",
  )

  === Kelola Glosarium

  #figure(
    image("bpmn/07_glosarium_latin/32_kelola_glosarium.svg"),
    caption: [Alur BPMN untuk proses _Kelola Glosarium_.],
    supplement: "Gambar",
  )

  == Asisten Riset AI

  === Tangani Permintaan AI

  #figure(
    image("bpmn/08_asisten_riset_ai/33_tangani_permintaan_ai.svg"),
    caption: [Alur BPMN untuk proses _Tangani Permintaan AI_.],
    supplement: "Gambar",
  )

  === Jelaskan Undang-Undang

  #figure(
    image("bpmn/08_asisten_riset_ai/34_jelaskan_undang_undang.svg"),
    caption: [Alur BPMN untuk proses _Jelaskan Undang-Undang_.],
    supplement: "Gambar",
  )

  === Cari Dengan AI

  #figure(
    image("bpmn/08_asisten_riset_ai/35_cari_dengan_ai.svg"),
    caption: [Alur BPMN untuk proses _Cari Dengan AI_.],
    supplement: "Gambar",
  )

  === Temukan Kasus Serupa

  #figure(
    image("bpmn/08_asisten_riset_ai/36_temukan_kasus_serupa.svg"),
    caption: [Alur BPMN untuk proses _Temukan Kasus Serupa_.],
    supplement: "Gambar",
  )

  === Laporkan Jawaban AI Keliru

  #figure(
    image("bpmn/08_asisten_riset_ai/37_laporkan_jawaban_ai_keliru.svg"),
    caption: [Alur BPMN untuk proses _Laporkan Jawaban AI Keliru_.],
    supplement: "Gambar",
  )
]

= Skenario _Testing_

TODO

= Desain Antarmuka

TODO
