Il seguente progetto è la versione di un cronometro creato il Flutter usando gli stream.

Per creare uno stream, ho generato una funzione asincrona. Usando Future, incrementa counter ogni secondo.
Per poter usare i metodi pause e resume sullo streamer è stato usato uno StreamSubcription al quale è stato assegnato lo Stream.

I metodi:
- startState() richiama lo streamer creato in precedenza e assegna a f(StreamSubcription) l'ogetto ritornato dalla funzione increment
- convertTime() converte il _counter (secondi) in una stringa di formato ore:minuti:secondi e aggiorna l'ogetto Text 
- pauseState() mette in pausa lo stream
- resumeState() riprende il contatore dello stream 
- restartState() mette in pausa lo stream e resetta il _counter (secondi), minuti e ore

Il widget build crea:
- una app bar con il titolo dell'applicazione e uno switch button che permette di scegliere tra light o dark mode
- un container nel body che al suo interno ha come child una colonna con più righe. Queste hanno al loro interno il Text contenente la stringa che mostra il valore del cronometro,
tre bottoni che avviano, mettono in pausa e resettano il cronometro


