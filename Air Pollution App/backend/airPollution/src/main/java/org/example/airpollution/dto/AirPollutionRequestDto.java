package org.example.airpollution.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class AirPollutionRequestDto {

    private String cityName;
    private LocalDate startDate;
    private LocalDate endDate;
}
