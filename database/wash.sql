-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 29 Des 2023 pada 16.19
-- Versi server: 10.4.27-MariaDB
-- Versi PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wash`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `date_created` datetime NOT NULL,
  `ktp` text NOT NULL,
  `status` int(11) NOT NULL,
  `nama_usaha` text NOT NULL,
  `alamat_usaha` text NOT NULL,
  `hp` text NOT NULL,
  `foto` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `admin`
--

INSERT INTO `admin` (`id`, `nama`, `email`, `password`, `date_created`, `ktp`, `status`, `nama_usaha`, `alamat_usaha`, `hp`, `foto`) VALUES
(5, 'Test', 'pemilik@pemilik.com', '58399557dae3c60e23c78606771dfa3d', '2022-01-17 12:59:30', '1642420770-1.jpg', 0, 'Test Usaha', 'Bandung', '08123123123', 'avatar.jpg'),
(8, 'admin', 'admin@gmail.com', '$2y$05$jWL.rEhtW2CaNm3/n9noSeRAWZdD1A32lLzhW7Rtuq.PQPhQJ2jKy', '2023-10-16 14:38:06', '1697459886-pngwing_com.png', 0, 'Car Wash 77', 'Cijoho', '08731679131', 'avatar.jpg'),
(9, 'CarWash77', 'carwash@gmail.com', '$2y$05$iAaMhGqr02qCEAWtlZDDSOw3lBn.KfqKkXKRDRbYamW0d4XK5187K', '2023-11-27 15:04:30', '', 1, 'Car Wash 77', 'Cijoho', '08794561251', '38ceafff286edd5a45f292cc887c7f16.png');

--
-- Trigger `admin`
--
DELIMITER $$
CREATE TRIGGER `delete_tempat_cuci` AFTER DELETE ON `admin` FOR EACH ROW BEGIN
DELETE FROM tempat_cuci
    WHERE id_pemilik = old.id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_tempat_cuci` AFTER INSERT ON `admin` FOR EACH ROW BEGIN
        INSERT INTO tempat_cuci
        set id_pemilik = NEW.id,
        nama = NEW.nama_usaha,
        alamat = NEW.alamat_usaha,
        hp = NEW.hp,
        email = NEW.email,
        status = NEW.status,
        foto1 = 'avatar.jpg',
        foto2 = 'avatar.jpg',
        foto3 = 'avatar.jpg',
        date_created = NEW.date_created;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_tempat_cuci` AFTER UPDATE ON `admin` FOR EACH ROW BEGIN
IF NEW.status <> OLD.status THEN
	UPDATE tempat_cuci
    SET status = NEW.status
    WHERE id_pemilik = old.id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `faq`
--

CREATE TABLE `faq` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `created_by` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `modified_by` int(11) NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `faq`
--

INSERT INTO `faq` (`id`, `question`, `answer`, `created_by`, `date_created`, `modified_by`, `date_modified`) VALUES
(9, 'Apakah seringnya mencuci dapat merusak lapisan cat kendaraan saya?', 'Sebagian besar manual kendaraan menyarankan seringnya mencuci mobil secara profesional karena perawatan lapisan bening dan pelindung lilin menyelamatkan kendaraan Anda dari efek merusak cuaca dan sinar UV matahari. Sering mencuci terbukti baik untuk kendaraan Anda, kecuali dinyatakan lain oleh dealer Anda.', 7, '2023-12-13 17:13:12', 7, '2023-12-15 13:29:15'),
(10, 'Apakah kuas, sabun, dan bahan kimia Anda aman untuk cat ?', 'Ya! Semua kuas dan sabun kami bersertifikat aman untuk cat dan tidak bersifat abrasif terhadap lapisan akhir kendaraan.', 7, '2023-12-13 17:14:36', 7, '2023-12-15 13:30:00'),
(11, 'Apakah jika melakukan penyedotan debu gratis? ', 'Ya! Penyedot debu bertenaga tinggi kami gratis untuk semua pelanggan yang membayar setelah setiap pencucian.', 7, '2023-12-15 13:30:18', 7, '2023-12-15 13:30:58'),
(12, 'Apakah anda menawarkan detail interior?', 'Kami tidak menawarkan detail interior. Sebagai gantinya, kami menyediakan handuk mikrofiber. Tisu lap dan pengharum ruangan disediakan tergantung jenis pencucian yang Anda pilih, sehingga Anda dapat melakukannya sendiri dengan cepat dan efisien. Semua situs menyediakan penyedot debu GRATIS untuk kenyamanan Anda. Dan terakhir, kami menawarkan pembersih keset, kompresor udara (untuk menghilangkan remah-remah yang mengganggu dari celah-celah), dan mesin penjual otomatis untuk produk detailing buatan sendiri yang terjangkau. Penawaran ini berbeda-beda di setiap situs.', 7, '2023-12-15 13:31:27', 7, '2023-12-15 13:31:27'),
(13, 'Jam berapa tempat cuci ini buka?', 'Kami mulai membuka tempat cuci mulai dari jam 10 pagi hingga 10 malam', 7, '2023-12-15 13:34:50', 7, '2023-12-15 13:34:50'),
(14, 'Apakah tempat cuci mobil ini ramah lingkungan?', 'tentu saja, Kami menggunakan lebih sedikit air dibandingkan jika Anda mencuci kendaraan di rumah, ditambah lagi sabun kami dapat terurai secara hayati dan dibuang di fasilitas kota yang tepat sehingga tidak masuk ke daerah aliran sungai setempat.', 7, '2023-12-15 13:35:37', 7, '2023-12-15 13:35:37'),
(15, 'Bagaimana jika saya kehilangan suatu barang di tempat cucian ini ! apa yang harus saya lakukan?', 'Jika Anda kehilangan barang di tempat cuci mobil kami, silakan kunjungi atau hubungi lokasi hilangnya barang tersebut segera setelah Anda menyadarinya. Tergantung pada situasi unik Anda, staf kami yang ramah akan memberikan instruksi dari sana.', 7, '2023-12-15 13:36:55', 7, '2023-12-15 13:36:55'),
(16, 'Bagaimana cara pemesanan tempat cuci ini ?', 'Untuk melakukan pemesanan silahkan login terlebih dahulu, lalu cari tempat cuci yang diinginkan dan silahkan inputkan data yang dibutuhkan termasuk jenis kendaraan, deskripsi kendaraan, lalu melakukan pembayaran yang sudah disediakan.', 7, '2023-12-15 13:38:58', 7, '2023-12-15 13:38:58'),
(17, 'Bagaimana melihat status transaksi yang sudah saya lakukan?', 'Cukup mudah pengguna hanya perlu pergi ke navigasi transaksi aktif di kanan atas yang biasanya disana akan menampilkan informasi transaksi yang sedang aktif dan pengguna dapat melakukan aksi seperti pembatalan, melihat detail transaksi, mencetak invoice hingga melihat cara pembayaran.', 7, '2023-12-15 13:40:48', 7, '2023-12-15 13:40:48'),
(18, 'Bagaimana jika saya ingin mengubah data diri yang sudah saya daftarkan?', 'Untuk memecahkan masalah tersebut pengguna harus login terlebih dahulu lalu pergi ke halaman profile, disana pengguna dapat edit profile hingga ganti password pengguna.', 7, '2023-12-15 13:42:39', 7, '2023-12-15 13:42:39');

-- --------------------------------------------------------

--
-- Struktur dari tabel `owner`
--

CREATE TABLE `owner` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `foto` text NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `owner`
--

INSERT INTO `owner` (`id`, `nama`, `email`, `password`, `foto`, `date_created`) VALUES
(7, 'owner', 'owner@gmail.com', '$2y$05$Lf6VEj0zCAwBt8DNgtl7aOE5O/f7rJZcZpyeYPpUDsJvYx8g/gqzK', 'avatar.jpg', '2023-11-27 13:51:48');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `jenis_kelamin` varchar(250) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `no_hp` text NOT NULL,
  `umur` int(20) NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `date_created` datetime NOT NULL,
  `image` text NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`id`, `nama`, `jenis_kelamin`, `alamat`, `no_hp`, `umur`, `email`, `password`, `date_created`, `image`, `status`) VALUES
(1, 'Dimas', '', '', '0', 0, 'dimas@gmail.com', '$2a$04$f7Im0uH.MMNXF523GJjrpOrPCHKPsN5XelLVtExYFVeogbQyX4kgm', '2022-01-11 03:34:13', '1642418900-gunhoo.jpeg', 1),
(3, 'Sabar', 'Laki-laki', 'Subang', '2147483647', 23, 'admin1111@gmail.com', '$2y$05$hwhUv6Cf9Z5/5GR4HLTLdO1Z7Zi5zI6MJE/T/fz.wuRMrrcnacPNG', '2023-09-29 14:52:55', 'avatar.jpg', 1),
(4, 'User', 'Perempuan', 'user', '081547891231', 21, 'username@gmail.com', '$2y$05$raEB.tfz34yURC3NnyaliOQKYILw7V1qvzjm.01C5NZq7OB40FBXW', '2023-10-16 14:37:00', '1702387862-logo.png', 1),
(5, 'perempuan', 'Perempuan', 'perempuan', '2147483647', 20, 'perempuan@gmail.com', '$2y$05$z6b08I5f/GbAPQbObHPwuutz90dsl83idYCSMwIBFXDdViewId3qe', '2023-11-27 15:52:04', 'avatar.jpg', 1),
(6, 'tes', 'Perempuan', 'tes', '2147483647', 20, 'tes@gmail.com', '$2y$05$LP0T6SijRGRRlhvuK8jDeOv.ro3RQAgBI0re1LfzfGitRZl3ws.52', '2023-12-05 11:31:34', 'avatar.jpg', 1),
(7, 'weqeq', 'Laki-laki', 'qwe', '08832382163', 12, 'aku@gmail.com', '$2y$05$Wv5vPSd32NpkQyjnu4oNjeaqtpXov5YkQPDJNdaLm9MRT2gG6QG7q', '2023-12-05 11:36:00', 'avatar.jpg', 1),
(8, 'asdada', 'Laki-laki', 'das', '12312', 123, 'ads@g', '$2y$05$vLUEX5T4hHZIoFtgp9HgOukdu1JgT7iNai3XcyHaX4FlekQMn1GrW', '2023-12-12 10:01:46', 'avatar.jpg', 1),
(9, 'roby', 'Laki-laki', 'asdada', '08821234979', 12, 'roby@gmail.com', '$2y$05$UWKgyNb/E466IZCBgv5WaeaiLv6SFuDeAGk8w8nDq404gfMtRcIAW', '2023-12-12 13:51:58', 'avatar.jpg', 1),
(10, 'civi', 'Laki-laki', '12345', '123456798891', 12, 'civi@gmail.com', '$2y$05$6PW/JPRNTOKqZCQQi175Tea4EOcbJZyUZFTRN8EuZUbj/e3TAF9f.', '2023-12-12 13:52:52', 'avatar.jpg', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `rating`
--

CREATE TABLE `rating` (
  `id_rating` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `feedback` text NOT NULL,
  `order_id` char(100) NOT NULL,
  `status` int(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `rating`
--

INSERT INTO `rating` (`id_rating`, `rating`, `feedback`, `order_id`, `status`) VALUES
(7, 4, 'Keren bangett', '760596837', 1),
(8, 5, 'Pencuciannya Terbaik', '2111306760', NULL),
(9, 3, 'Lumayan lah\r\n', '529028740', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tempat_cuci`
--

CREATE TABLE `tempat_cuci` (
  `id` int(11) NOT NULL,
  `id_pemilik` int(11) NOT NULL,
  `nama` text NOT NULL,
  `alamat` text NOT NULL,
  `hp` text NOT NULL,
  `email` text NOT NULL,
  `maps` text NOT NULL,
  `deskripsi` text NOT NULL,
  `kategori` int(11) NOT NULL,
  `harga_mobil_besar` int(11) NOT NULL,
  `harga_mobil_kecil` int(11) NOT NULL,
  `foto1` text NOT NULL,
  `foto2` text NOT NULL,
  `foto3` text NOT NULL,
  `status` int(11) NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `tempat_cuci`
--

INSERT INTO `tempat_cuci` (`id`, `id_pemilik`, `nama`, `alamat`, `hp`, `email`, `maps`, `deskripsi`, `kategori`, `harga_mobil_besar`, `harga_mobil_kecil`, `foto1`, `foto2`, `foto3`, `status`, `date_created`) VALUES
(7, 9, '77 Car Wash', 'Cijoho', '08794561251', 'carwash@gmail.com', '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3960.3355626989533!2d108.49043817499691!3d-6.969681293030918!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e6f17e9909f353f%3A0xd6005cb9d1b55b5c!2s77%20Car%20Wash!5e0!3m2!1sid!2sid!4v1702634220155!5m2!1sid!2sid\" width=\"800\" height=\"600\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', '<p>Kategori Mobil Ukuran Kecil :&nbsp;</p><p>Jazz , Brio , Atos , Yaris , Pick up , Karimun , March , Agya , Ayla, Avanza , Xenia , xpander , Rush , Terios , Apv , Innova , Mobilio , Crv , Hrv , Brv , Sigra , Calya , Freed, Terrano , Grand Livina, ertiga</p><p>&nbsp;</p><p>Kategori Mobil Ukuran Besar :&nbsp;</p><p>Pajero , fortuner , double kabin, Hiace&nbsp;,&nbsp;elp</p>', 1, 50000, 35000, '1702014986-logo.png', '1702000515-2.jpg', '1702000537-5.jpg', 1, '2023-11-27 15:04:30');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `order_id` char(100) NOT NULL,
  `gross_amount` int(11) NOT NULL,
  `payment_type` varchar(13) NOT NULL,
  `transaction_time` datetime NOT NULL,
  `bank` varchar(10) DEFAULT NULL,
  `va_number` varchar(30) DEFAULT NULL,
  `pdf_url` text DEFAULT NULL,
  `status_code` char(3) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `kendaraan` text NOT NULL,
  `deskripsi_mobil` text NOT NULL,
  `tanggal_pesan` date NOT NULL,
  `id_pelanggan` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `email` text NOT NULL,
  `no_hp` varchar(20) NOT NULL,
  `id_tempat_cuci` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`order_id`, `gross_amount`, `payment_type`, `transaction_time`, `bank`, `va_number`, `pdf_url`, `status_code`, `status`, `kendaraan`, `deskripsi_mobil`, `tanggal_pesan`, `id_pelanggan`, `nama`, `alamat`, `email`, `no_hp`, `id_tempat_cuci`) VALUES
('1050579121', 50000, 'qris', '2023-12-28 12:02:44', NULL, NULL, NULL, '202', 4, '2', '', '2023-12-28', 4, 'User', 'user', 'username@gmail.com', '081547891231', 7),
('1470566185', 40000, 'bank_transfer', '2023-12-15 18:08:46', NULL, '13685729368', 'https://app.sandbox.midtrans.com/snap/v1/transactions/a6674b83-a51c-450d-b9de-93b0b7edf434/pdf', '202', 4, '1', '12314', '2023-12-15', 4, 'User', 'user', 'username@gmail.com', '081547891231', 7),
('1695213155', 40000, 'bank_transfer', '2023-12-28 00:37:01', NULL, '13685080591', 'https://app.sandbox.midtrans.com/snap/v1/transactions/0c8acb20-eb2f-49b6-b2ee-b0f2aee62720/pdf', '202', 4, '1', '', '2023-12-28', 4, 'User', 'user', 'username@gmail.com', '081547891231', 7),
('2111306760', 40000, 'bank_transfer', '2023-12-28 12:40:34', NULL, '13685259514', 'https://app.sandbox.midtrans.com/snap/v1/transactions/83c12dfc-c072-4b1f-927c-1f5a577dcc00/pdf', '200', 3, '1', '123', '2023-12-28', 4, 'User', 'user', 'username@gmail.com', '081547891231', 7),
('2142134740', 40000, 'bank_transfer', '2023-12-28 11:40:14', NULL, '13685210951', 'https://app.sandbox.midtrans.com/snap/v1/transactions/68101bd2-94ba-48a9-bf8d-78bedff80e75/pdf', '202', 4, '1', '123', '2023-12-28', 4, 'User', 'user', 'username@gmail.com', '081547891231', 7),
('2145736264', 50000, 'bank_transfer', '2023-12-29 19:31:54', NULL, '13685668756', 'https://app.sandbox.midtrans.com/snap/v1/transactions/dc8b03d9-f8b2-4c6c-9262-39df024cbad7/pdf', '200', 2, '2', 'e 1234 ads', '2023-12-29', 4, 'User', 'user', 'username@gmail.com', '081547891231', 7),
('487658811', 35000, 'bank_transfer', '2023-12-29 20:34:09', NULL, '13685033550', 'https://app.sandbox.midtrans.com/snap/v1/transactions/a1fde9d8-c941-4592-bd26-a298f55e765d/pdf', '200', 1, '2', 'E 1235 YRE', '2023-12-29', 4, 'User', 'user', 'username@gmail.com', '081547891231', 7),
('529028740', 40000, 'bank_transfer', '2023-12-15 18:07:16', NULL, '13685372847', 'https://app.sandbox.midtrans.com/snap/v1/transactions/b40a6e47-0183-4199-81f4-1571b60e80d6/pdf', '200', 3, '1', 'Honda JAzz', '2023-12-15', 4, 'User', 'user', 'username@gmail.com', '081547891231', 7),
('680565670', 40000, 'qris', '2023-12-28 00:39:39', NULL, NULL, NULL, '202', 4, '1', '', '2023-12-28', 4, 'User', 'user', 'username@gmail.com', '081547891231', 7),
('760596837', 40000, 'bank_transfer', '2023-12-29 19:25:26', NULL, '13685984592', 'https://app.sandbox.midtrans.com/snap/v1/transactions/e3fb0aec-7bb8-41bf-aca1-f1c62b250a4e/pdf', '200', 3, '1', 'E 1231 EQR', '2023-12-29', 4, 'User', 'user', 'username@gmail.com', '081547891231', 7);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indeks untuk tabel `faq`
--
ALTER TABLE `faq`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `created_by` (`created_by`) USING BTREE,
  ADD KEY `modified_by` (`modified_by`) USING BTREE;

--
-- Indeks untuk tabel `owner`
--
ALTER TABLE `owner`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indeks untuk tabel `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`id_rating`) USING BTREE,
  ADD KEY `order_id` (`order_id`) USING BTREE;

--
-- Indeks untuk tabel `tempat_cuci`
--
ALTER TABLE `tempat_cuci`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id_pemilik` (`id_pemilik`) USING BTREE;

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`order_id`) USING BTREE,
  ADD KEY `id_pelanggan` (`id_pelanggan`) USING BTREE,
  ADD KEY `id_tempat_cuci` (`id_tempat_cuci`) USING BTREE;

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `faq`
--
ALTER TABLE `faq`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT untuk tabel `owner`
--
ALTER TABLE `owner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `rating`
--
ALTER TABLE `rating`
  MODIFY `id_rating` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `tempat_cuci`
--
ALTER TABLE `tempat_cuci`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `faq`
--
ALTER TABLE `faq`
  ADD CONSTRAINT `faq_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `owner` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `faq_ibfk_2` FOREIGN KEY (`modified_by`) REFERENCES `owner` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `transaksi` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tempat_cuci`
--
ALTER TABLE `tempat_cuci`
  ADD CONSTRAINT `tempat_cuci_ibfk_1` FOREIGN KEY (`id_pemilik`) REFERENCES `admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_tempat_cuci`) REFERENCES `tempat_cuci` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
