url <- "https://www.ine.pt/ngt_server/attachfileu.jsp?look_parentBoui=686649304&att_display=n&att_download=y"

raw_data <- paste0("dados\\original\\", "IPH2024.xlsx") # pasta em que guardamos os dados originais

download.file(url, raw_data,
              method = "auto",
              mode = "wb")

# função que extrai os valores de 2019 a 2024 das folhas especificadas

extrai <- function(caminho = raw_data, folha = 'Q1'){

  readxl::read_excel(path = caminho,
                     skip = 3,
                     sheet = folha) |>
    dplyr::mutate(ano = substr(`Período`, 3,7)) |>
    dplyr::filter(ano >= '2019',
                  ano <= '2024') |>
    dplyr::mutate(across(-`Período`, as.numeric))

}

extrai(caminho = raw_data, folha = 'Q1') |>
  dplyr::rename(periodo = 1,
                ind_tn = 2,
                ind_ex = 3,
                ind_nv = 4,
                vt_tn = 5,
                vt_ex = 6,
                vt_ns = 7,
                vh_tn = 8,
                vh_ex = 9,
                vh_ns = 10,
                vm_tn = 11,
                vm_ex = 12,
                vm_ns = 13,
                trs_tn = 14,
                trs_ex = 15,
                trs_ns = 16) |> write.csv2("dados\\preparados\\iph_q1.csv", row.names = FALSE)

extrai(caminho = raw_data, folha = 'Q5') |>
  dplyr::rename(periodo = 1,
                tot_v = 2,
                tot_n = 3,
                nort_v = 4,
                nort_n = 5,
                prt_v = 6,
                prt_n = 7,
                ctr_v = 8,
                ctr_n = 9,
                ovt_v = 10,
                ovt_n = 11,
                lx_v = 12,
                lx_n = 13,
                stb_v = 14,
                stb_n = 15,
                alt_v = 16,
                alt_n = 17,
                alg_v = 18,
                alg_n = 19,
                acr_v = 20,
                acr_n = 21,
                mad_v = 22,
                mad_n = 23) |> write.csv2("dados\\preparados\\iph_q5.csv", row.names = FALSE)


extrai(caminho = raw_data, folha = 'Q6') |>
  dplyr::rename(periodo = 1,
                tot_v = 2,
                tot_n = 3,
                tn_v = 4,
                tn_n = 5,
                ue_v = 6,
                ue_n = 7,
                rst_v = 8,
                rst_n = 9) |> write.csv2("dados\\preparados\\iph_q6.csv", row.names = FALSE)
