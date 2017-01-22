# elkb-training


### rpmでlogstashをインストールし、一般ユーザでlogstashを動作させる手順

1. logstash動作用のディレクトリを作成する

  ```
  mkdir logstash
  ```

2. logstashの設定ファイルを作成する

  ```
  vi logstash/logstash.yml
  ------------------------------------------------------------
  path.data: ./logstash/data
  path.config: ./logstash/conf.d
  path.queue: ./logstash/data/queue
  path.logs: ./logstash/log
  ------------------------------------------------------------
  ```

3. logstashの設定ファイルを作成する

  ```
  vi logstash/logstash.conf
  ------------------------------------------------------------
  (例)
  input {
        stdin {
        }
  }

  output {
         stdout {
                codec => rubydebug
         }
  }
  ------------------------------------------------------------
  ```

4. 設定ファイルの動作確認を実施する

  ```
  /usr/share/logstash/bin/logstash -f logstash/logstash.conf --path.settings ./logstash  -t
  ```

5 動作

  ```
  /usr/share/logstash/bin/logstash -f logstash/logstash.conf --path.settings ./logstash  -r
  ```
