CREATE TABLE `evidence_storage` (
  `id` int(11) NOT NULL,
  `data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE `evidence_storage`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `evidence_storage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;