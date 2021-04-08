### Build LED data package for use with Math 119
# See data_led_private repo
pacman::p_load(tidyverse, glue, readxl, fs)
pacman::p_load_gh("byuidss/DataPushR")

set.seed(20200313)

## Read in data

### Testing Data

sheet_names <- excel_sheets("../data_led_private/data/DataUsedForAnalysis.xlsx")

dat_list <- sheet_names[c(3,7)] %>% map(~read_xlsx("../data_led_private/data/DataUsedForAnalysis.xlsx", sheet = .x))

led_testing <- dat_list %>%
  map(~pivot_longer(.x, -Hours, names_to = "id", 
                    values_to = "percent_intensity")) %>%
  bind_rows() %>%
  mutate(company = ifelse(str_detect(id, "AAA"), "A", "B"),
         id = parse_number(id),
         normalized_intensity = percent_intensity,
         percent_intensity = 100*normalized_intensity) %>%
  select(id, hours = Hours, normalized_intensity, percent_intensity, company)

led_test_details <- list(id = "An id for each LED light measured",
                         hours = "The number of hours since the first measurement",
                         normalized_intensity = "The normalized light output based on the first measured intensity of the bulb",
                         percent_intensity = "The normalized_intensity multiplied by 100",
                         company = "Either A or B to represent to different company products")


load("../data_led_private/data/LumenData.Rdata")
# dat object from the .Rdata file



### Study data ####

led_study <- dat %>%
  select(ID, Hours, Intensity, NI) %>%
  rename_all("str_to_lower") %>%
  rename(percent_intensity = ni) %>%
  mutate(hours = floor(hours)) %>%
  group_by(id) %>%
  mutate(intensity = intensity + rnorm(n(), mean = 0, sd = .25),
         normalized_intensity = intensity / intensity[1],
         percent_intensity = normalized_intensity*100,
         hours = ifelse(hours < 10, 0, hours)) %>%
  ungroup() %>%
  filter(hours > 25 | hours < 10) %>%
  as_tibble() %>%
  mutate(hours = ifelse(hours == 191, 192, hours)) %>%
  select(id, hours, intensity, normalized_intensity, percent_intensity)

led_study_details <- list(id = "An id for each LED light measured",
                          hours = "The number of hours since the first measurement",
                          intensity = "The lumen output of the bulb. 800 lumens maps to a 60 watt incandescent bulb (https://www.lumens.com/how-tos-and-advice/light-bulb-facts.html)",
                          normalized_intensity = "The normalized light output based on the first measured intensity of the bulb",
                          percent_intensity = "The normalized_intensity multiplied by 100")


list_data = list(led_study = led_study, led_testing = led_testing)

#################
#################
#################

#usethis::browse_github_token()


package_name_text <- "data4led"
base_folder <- "../../byuidatascience/"
user <- "byuidatascience"
package_path <- str_c(base_folder, package_name_text)

####  Run to create repo locally and on GitHub.  ######

# github_info <- dpr_create_github(user, package_name_text)
# 
# package_path <- dpr_create_package(list_data = NULL,
#                                      package_name = package_name_text,
#                                      export_folder = base_folder,
#                                      git_remote = github_info$clone_url)

##### dpr_delete_github(user, package_name_text) ####

####### End create section

github_info <- dpr_info_github(user, package_name_text)
usethis::proj_set(package_path)

dpr_export(led_study, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(led_testing, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

usethis::use_data(led_study, led_testing, overwrite = TRUE)

dpr_document(led_study, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "led_study", title = "LED example bulbs of lumen output",
             description = "An example data set of LED bulbs based on actual data.",
             source = "data_led_private",
             var_details = led_study_details)

dpr_document(led_testing, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "led_testing", 
             title = "LED example bulbs of lumen output for two products with standard procedure time point measurements",
             description = "An example data set of LED bulbs based on actual data.",
             source = "data_led_private",
             var_details = led_test_details)

dpr_readme(usethis::proj_get(), package_name_text, user)

dpr_write_script(folder_dir = package_path, r_read = "scripts/LED_package.R", 
                 r_folder_write = "data-raw", r_write = str_c(package_name_text, ".R"))

devtools::document(package_path)

dpr_push(folder_dir = package_path, message = "'documentation'", repo_url = NULL)



### Some plots


led_study %>%
  ggplot(aes(x = hours, y = percent_intensity)) +
  geom_line(aes(group = id), color = "grey", alpha = .25) +
  geom_point() +
  theme_bw()


led_study %>%
  ggplot(aes(x = hours, y = percent_intensity)) +
  geom_line(aes(group = id), color = "grey", alpha = .25) +
  geom_point() +
  theme_bw() +
  coord_cartesian(xlim = c(20,30))


led_study %>%
  ggplot(aes(x = hours, y = intensity)) +
  geom_line(aes(group = id), color = "grey", alpha = .25) +
  geom_point() +
  theme_bw()
