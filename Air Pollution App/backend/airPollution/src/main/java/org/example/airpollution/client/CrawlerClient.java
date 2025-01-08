package org.example.airpollution.client;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.airpollution.dto.Pollution;
import org.example.airpollution.dto.QueueRequestPollutionRecordDto;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class CrawlerClient implements ICrawlerClient
{
    public static final String API_POLLUTION_URL ="http://api.openweathermap.org/data/2.5/air_pollution/history?lat=%s&lon=%s&start=%s&end=%s&appid=a7ada9e4cf046c8e0366d43e10d90101";

    private final IHttpRequestExecutor httpRequestExecutor;


    @Override
    public Pollution fetchPollution(QueueRequestPollutionRecordDto queueRequestPollutionRecordDto) {
        String url = String.format(API_POLLUTION_URL, queueRequestPollutionRecordDto.getLat(), queueRequestPollutionRecordDto.getLon(),
                queueRequestPollutionRecordDto.getStartDate(),queueRequestPollutionRecordDto.getStartDate());

        return httpRequestExecutor.executeGetRequest(url, Pollution.class);
    }
}
