package org.example.airpollution.PollutionDto;

import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Setter
public class AirQualityData {

    private Main main;
    private Components components;
    private long dt;
}
