package org.example.airpollution.PollutionDto;

import lombok.*;

import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Setter
public class AirQualityResponse {
    private Coord coord;
    private List<AirQualityData> list;
}
