package org.example.airpollution.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PollutionRecordDto {

    private Long date;

    private Float lat;

    private Float lon;

    private Float carbonMonoxide;

    private Float ozone;

    private Float sulphurDioxide;

}
