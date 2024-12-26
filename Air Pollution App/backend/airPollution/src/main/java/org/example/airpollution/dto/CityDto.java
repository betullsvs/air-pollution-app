package org.example.airpollution.dto;


import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.util.Map;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Setter
public class CityDto {

    @JsonProperty("name")
    private String name;

    @JsonProperty("lat")
    private Float lat;

    @JsonProperty("lon")
    private Float lon;

    @JsonIgnore  // JSON serialization sırasında yoksay
    private Map<String, String> local_names;

    @JsonProperty("country")
    private String country;

    @JsonIgnore
    private Map<String, String> state;


}
