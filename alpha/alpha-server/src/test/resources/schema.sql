/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

CREATE TABLE IF NOT EXISTS TxEvent (
  surrogateId bigint GENERATED BY DEFAULT AS IDENTITY(START WITH 1, INCREMENT BY 1) PRIMARY KEY,
  serviceName varchar(36) NOT NULL,
  instanceId varchar(36) NOT NULL,
  creationTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  globalTxId varchar(36) NOT NULL,
  localTxId varchar(36) NOT NULL,
  parentTxId varchar(36) DEFAULT NULL,
  type varchar(50) NOT NULL,
  compensationMethod varchar(256) NOT NULL,
  expiryTime TIMESTAMP NOT NULL,
  retryMethod varchar(256) NOT NULL,
  retries int DEFAULT 0 NOT NULL,
  payloads blob
);

CREATE TABLE IF NOT EXISTS Command (
  surrogateId bigint GENERATED BY DEFAULT AS IDENTITY(START WITH 1, INCREMENT BY 1) PRIMARY KEY,
  eventId bigint NOT NULL UNIQUE,
  serviceName varchar(36) NOT NULL,
  instanceId varchar(36) NOT NULL,
  globalTxId varchar(36) NOT NULL,
  localTxId varchar(36) NOT NULL,
  parentTxId varchar(36) DEFAULT NULL,
  compensationMethod varchar(256) NOT NULL,
  payloads blob,
  status varchar(12),
  lastModified TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  version bigint NOT NULL
);

CREATE TABLE IF NOT EXISTS TxTimeout (
  surrogateId bigint GENERATED BY DEFAULT AS IDENTITY(START WITH 1, INCREMENT BY 1) PRIMARY KEY,
  eventId bigint NOT NULL UNIQUE,
  serviceName varchar(36) NOT NULL,
  instanceId varchar(36) NOT NULL,
  globalTxId varchar(36) NOT NULL,
  localTxId varchar(36) NOT NULL,
  parentTxId varchar(36) DEFAULT NULL,
  type varchar(50) NOT NULL,
  expiryTime TIMESTAMP NOT NULL,
  status varchar(12),
  version bigint NOT NULL
);

CREATE TABLE IF NOT EXISTS TccParticipateEvent (
  id bigint GENERATED BY DEFAULT AS IDENTITY(START WITH 1, INCREMENT BY 1) PRIMARY KEY,
  serviceName varchar(36) NOT NULL,
  instanceId varchar(36) NOT NULL,
  globalTxId varchar(36) NOT NULL,
  localTxId varchar(36) NOT NULL,
  parentTxId varchar(36) DEFAULT NULL,
  confirmMethod varchar(256) NOT NULL,
  cancelMethod varchar(256) NOT NULL,
  status varchar(50) NOT NULL,
  creationTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  lastModified TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS TccFinishedEvent (
  id bigint GENERATED BY DEFAULT AS IDENTITY(START WITH 1, INCREMENT BY 1) PRIMARY KEY,
  serviceName varchar(36) NOT NULL,
  instanceId varchar(36) NOT NULL,
  globalTxId varchar(36) NOT NULL,
  localTxId varchar(36) NOT NULL,
  parentTxId varchar(36) DEFAULT NULL,
  confirmMethod varchar(256) NOT NULL,
  cancelMethod varchar(256) NOT NULL,
  status varchar(50) NOT NULL,
  creationTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  lastModified TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
