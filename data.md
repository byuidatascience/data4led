## LED example bulbs of lumen output

The data is called led_study.

### Description

An example data set of LED bulbs based on actual data.

The source of this data is < data_led_private >

### Data format

A data frame with columns:

|variable          |class   |description                                                                                                                                    |
|:-----------------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------|
|id                |integer |An id for each LED light measured                                                                                                              |
|hours             |numeric |The number of hours since the first measurement                                                                                                |
|intensity         |numeric |The lumen output of the bulb. 800 lumens maps to a 60 watt incandescent bulb (https://www.lumens.com/how-tos-and-advice/light-bulb-facts.html) |
|percent_intensity |numeric |The percent light output based on the first measured intensity of the bulb                                                                     |



## LED example bulbs of lumen output for two products with standard procedure time point measurements

The data is called led_testing.

### Description

An example data set of LED bulbs based on actual data.

The source of this data is < data_led_private >

### Data format

A data frame with columns:

|variable          |class     |description                                                                |
|:-----------------|:---------|:--------------------------------------------------------------------------|
|id                |numeric   |An id for each LED light measured                                          |
|hours             |numeric   |The number of hours since the first measurement                            |
|percent_intensity |numeric   |The percent light output based on the first measured intensity of the bulb |
|company           |character |Either A or B to represent to different company products                   |



