# usage:
# awk -v lesson=15 -v action=u -f generate_sql.awk lessons15.txt

BEGIN {
  FS = ";"
  i = 1
};
{
  word_id=0
  if(i < 10){
    word_id = lesson"0"i
  } else {
    word_id = lesson""i
  }
  if(action == "i"){
    print "INSERT INTO WORDS VALUES("word_id","lesson",\x27"$1"\x27,\x27"$2"\x27,\x27"$3"\x27);"
    print "INSERT INTO TRANSLATIONS VALUES("word_id",\x27"$4"\x27);"
  } else {
    print "UPDATE WORDS SET KANJI=\x27"$1"\x27, KANA=\x27"$2"\x27, ROMANJI=\x27"$3"\x27 WHERE WORD_ID="word_id";"
    print "UPDATE TRANSLATIONS SET TRANSLATION=\x27"$4"\x27 WHERE WORD_ID="word_id";"
  }
  ++i
}

