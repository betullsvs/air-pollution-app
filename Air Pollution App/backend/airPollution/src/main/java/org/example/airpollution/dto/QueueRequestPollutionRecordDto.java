package org.example.airpollution.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QueueRequestPollutionRecordDto {

    private Float lat;
    private Float lon;
    private Long startDate;
    private Long endDate;
}
