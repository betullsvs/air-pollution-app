package org.example.airpollution.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.example.airpollution.PollutionDto.AirQualityResponse;
import org.example.airpollution.dto.AirPollutionRequestDto;
import org.example.airpollution.dto.CityDto;
import org.example.airpollution.dto.QueueRequestPollutionRecordDto;
import org.example.airpollution.model.City;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
@RequiredArgsConstructor
public class CityService implements ICityService{

    @Autowired
    private RestTemplate restTemplate;



    @Override
    public City getCityDetailFromApi(AirPollutionRequestDto airPollutionRequestDto) {
        String url = "http://api.openweathermap.org/geo/1.0/direct?q=" + airPollutionRequestDto.getCityName() + "&appid=a7ada9e4cf046c8e0366d43e10d90101";

        // Make the API call
        String jsonResponse = restTemplate.getForObject(url, String.class);
        System.out.println(jsonResponse);

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            CityDto[] result = objectMapper.readValue(jsonResponse, CityDto[].class);

            CityDto cityDto = result[0];

            return City.builder()
                    .name(cityDto.getName())
                    .lat(cityDto.getLat())
                    .lon(cityDto.getLon())
                    .country(cityDto.getCountry())
                    .build();

        }catch (Exception e){
            e.printStackTrace();
            return null;
        }

    }

    @Override
    public AirQualityResponse getAirQuality(QueueRequestPollutionRecordDto queueRequestPollutionRecordDto) {
        String url = "http://api.openweathermap.org/data/2.5/air_pollution/history?lat="+queueRequestPollutionRecordDto.getLat()+"&lon="+queueRequestPollutionRecordDto.getLon()+"&start="+queueRequestPollutionRecordDto.getStartDate()+"&end="+queueRequestPollutionRecordDto.getEndDate()+"&appid=a7ada9e4cf046c8e0366d43e10d90101";

        // Make the API call
        String jsonResponse = restTemplate.getForObject(url, String.class);
        System.out.println(jsonResponse);

        try {
            // JSON'u DTO'ya dönüştür
            ObjectMapper objectMapper = new ObjectMapper();
            AirQualityResponse response = objectMapper.readValue(jsonResponse, AirQualityResponse.class);

            // Dönüşümü kontrol et ve gerekiyorsa işleme yap
            return response;

        } catch (Exception e) {
            e.printStackTrace();
            return null; // Hata durumunda null döndür
        }

    }
}
