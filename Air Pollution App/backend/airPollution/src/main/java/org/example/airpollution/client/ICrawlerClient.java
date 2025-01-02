package org.example.airpollution.client;

import org.example.airpollution.dto.Pollution;
import org.example.airpollution.dto.QueueRequestPollutionRecordDto;


public interface ICrawlerClient
{

    Pollution fetchPollution(QueueRequestPollutionRecordDto queueRequestPollutionRecordDto);

}
