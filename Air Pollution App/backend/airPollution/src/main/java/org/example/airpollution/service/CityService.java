package org.example.airpollution.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.example.airpollution.PollutionDto.AirQualityResponse;
import org.example.airpollution.dto.AirPollutionRequestDto;
import org.example.airpollution.dto.CityDto;
import org.example.airpollution.dto.QueueRequestPollutionRecordDto;
import org.example.airpollution.model.City;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
@RequiredArgsConstructor
public class CityService implements ICityService{


    @Autowired
    private RestTemplate restTemplate;

    private final Map<String, AirQualityResponse> cityAirData = new ConcurrentHashMap<>();

    private final Map<String, float[]> cityCoordinates = Map.of(
            "Istanbul", new float[]{41.0082f, 28.9784f},
            "Ankara", new float[]{39.9208f, 32.8541f},
            "Izmir", new float[]{38.4192f, 27.1287f}
    );




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

    @Scheduled(fixedRate = 3600000) // saatte bir çalışır
    @Override
    public void getPopularCitiesData() {
        System.out.println("Hava kirliliği verileri güncellemesi başladı: " + LocalDateTime.now());

        QueueRequestPollutionRecordDto dto = new QueueRequestPollutionRecordDto();

        for (Map.Entry<String, float[]> entry : cityCoordinates.entrySet()) {
            String city = entry.getKey();
            float[] coordinates = entry.getValue();
            float lat = coordinates[0];
            float lon = coordinates[1];

            try {
                LocalDateTime localDateTime = LocalDateTime.now();
                ZoneId zoneId = ZoneId.systemDefault();
                ZonedDateTime zonedDateTime = localDateTime.atZone(zoneId);

                dto.setLon(lon);
                dto.setLat(lat);
                dto.setEndDate(zonedDateTime.toInstant().getEpochSecond());
                dto.setStartDate(zonedDateTime.toInstant().getEpochSecond() - 3600);

                // Log: Şehir verisi güncelleniyor
                System.out.println(city + " için hava kirliliği verileri güncelleniyor...");

                // API'ye istek at
                AirQualityResponse response = getAirQuality(dto);

                if (response != null) {
                    // Gelen yanıtı cache'e ekle
                    cityAirData.put(city, response);

                    // Log: Güncelleme başarılı
                    System.out.println(city + " için hava kirliliği verileri güncellendi.");
                }
            } catch (Exception e) {
                // Log: Hata durumu
                System.err.println(city + " için API isteği başarısız oldu: " + e.getMessage());
            }
        }

        // Log: Güncelleme tamamlandı
        System.out.println("Hava kirliliği verileri güncellemesi tamamlandı: " + LocalDateTime.now());


    }
    @Override
    public Map<String, AirQualityResponse> getCityAirData() {

        return cityAirData;
    }


}
