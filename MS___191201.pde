/*以下MSと記述されている部分があるが、これは魔方陣(Magic Square）のことである*/
/*このプログラムでは魔方陣の「位置」という言葉を使うが位置1が左上のマス、位置2がその右のマスとし、
 位置4は右端のマスで右端まで行ったら、1つ下の行の左端のマスを次の番号（この場合は位置5とする)*/
int MS[][];//最初に求める全880種類の魔方陣を格納する
int MS1[][];//位置1の値が合致する魔方陣だけを格納する配列
int MS2[][];//位置1～2までの値　　　　　　〃
int MS3[][];//位置1～3までの値　　　　　　〃
int MS5[][];//位置1～5までの値　　　　　　〃　　　　
int MS6[][];//位置1～6までの値　　　　　　〃　　　　
int MS7[][];//位置1～7までの値　　　　　　〃　　　　
int MS9[][];//位置1～9までの値　　　　　　〃　　　　
int [] k=new int [17];//keyboardから入力される数を保存するための配列（番号は入力順）

int ans[][];//位置1の値が合致する魔方陣の種類数格納する配列
int ans2[][];//位置1～2までの値が　　　　　　〃
int ans3[][][];//位置1～3までの値が　　　　　〃
int ans5[][][][]; //位置1～5までの値が　　　 〃
int ans6[][][][][];//位置1～6までの値が　　　〃
int ans7[][][][][][]; //位置1～7までの値が　 〃
int ans9[][][][][][][]; //位置1～9までの値が 〃

int Mode=1;//modeを指定 modeの数は入力された文字数をカウント
int Mode1=1;
boolean Modeh=false;//ヘルプ画面の立ち上げのモード判定
boolean Moder=false;//ルール説明画面の立ち上げモード判定

/*魔方陣の枠の設定*/
int ulx=160;   //枠の左上x
int uly=100;   //枠の左上y
int intx=70;  //間隔ｘ
int inty=70;  //間隔y

int textx=195; //左上の文字の座標
int texty=155;
void setup() {
  PFont font = createFont("MS Gothic", 48, true);//日本語が表示されるように加える
  textFont(font);
  size(600, 480);
  cl();

  int num[][];//魔方陣の座標(左側が縦列で左から右に行くにつれて大きくなり、右側が横列で上から下に行くにつれて大きくなるように設定した。
  int n=4; //nは魔方陣の次数
  num=new int[n+2][];
  MS=new int[881][17];

  for (int i=1; i<=n+1; i++) { //2次元配列の設定
    num[i]=new int[n+1];
  }
  int z, count=0;
  boolean [] used=new boolean[17];//その数字を使っているか否かをフラグで判定

  for (z=1; z<=16; z++) used[z]=false; // フラグのクリア 

  /*基本的にif文を用いて以下の3点のことを守っているかの判定を行い4×4の魔方陣全880種類を出力
   1.同じ数を使っていないか
   2.代入されている値が1以上16以下であるか
   3.裏返し、回転して同一のものにならないか（重複条件)*/
  for (num[1][1]=1; num[1][1]<=13; num[1][1]++) { //1.左上の数(位置1)を特定
    used[num[1][1]]=true; 
    for (num[1][4]=num[1][1]+1; num[1][4]<=15; num[1][4]++) { //2.位置4の値を特定(重複を防ぐため、ループはnum[1][1]+1から）
      used[num[1][4]]=true;
      for (num[4][1]=num[1][4]+1; num[4][1]<=16; num[4][1]++) {  //3.位置13の値を特定(重複を防ぐため、ループはnum[1][4]+1から）
        num[4][4]=34-num[1][1]-num[1][4]-num[4][1];              //1～3より四隅の条件から右下(位置16）も求められる
        if (num[4][4]<num[1][1]) break;                        //重複条件の排除用 
        if (num[4][4]>16||used[num[4][4]]||num[4][4]==num[4][1]) continue;  
        used[num[4][1]]=used[num[4][4]]=true;                    // 使用済みのフラグを立てる 
        for (num[2][2]=1; num[2][2]<=16; num[2][2]++) {// 4,位置6の数を特定
          if (used[num[2][2]]) continue;            
          num[3][3]=34-num[1][1]-num[2][2]-num[4][4];  //斜めの和より位置11の値を計算 
          if (num[3][3]<1) break;                      // 1以上であることを確認
          if (num[3][3]>16||used[num[3][3]]||num[2][2]==num[3][3]) continue;                  
          used[num[2][2]]=used[num[3][3]]=true;                   
          for (num[1][2]=1; num[1][2]<=16; num[1][2]++) {     //5.位置2の数の特定
            if (used[num[1][2]]) continue;
            num[1][3]=34-num[1][1]-num[1][2]-num[1][4];  //横列の和より位置3の値を計算 
            if (num[1][3]<1) break;
            if (num[1][3]>16||used[num[1][3]]||num[1][2]==num[1][3]) continue;
            used[num[1][2]]=used[num[1][3]]=true;
            for (num[2][3]=1; num[2][3]<=16; num[2][3]++) {   //6.位置7の数の特定
              if (used[num[2][3]]) continue;
              num[3][2]=34-num[1][4]-num[2][3]-num[4][1];   //斜めの和より位置10の値を計算
              if (num[3][2]<1) break;
              if (num[3][2]>16||used[num[3][2]]||num[3][2]==num[2][3]) continue;
              num[4][3]=34-num[1][3]-num[2][3]-num[3][3];//縦列の和より位置15の値を計算
              if (num[4][3]<1) break;
              if (num[4][3]>16||used[num[4][3]]||num[4][3]==num[2][3] || num[4][3]==num[3][2]) continue;
              num[4][2]=34-num[1][2]-num[2][2]-num[3][2];//縦列の和より位置14の値を計算
              if (num[4][2]>16) break;
              if (num[4][2]<1||used[num[4][2]]||num[4][2]==num[2][3] || num[4][2]==num[3][2] || num[4][2]==num[4][3]) continue;
              used[num[2][3]]=used[num[3][2]]=used[num[4][3]]=used[num[4][2]]=true;
              for (num[2][1]=1; num[2][1]<=16; num[2][1]++) {       //7.位置5の数の特定
                if (used[num[2][1]]) continue;
                num[2][4]=34-num[2][1]-num[2][2]-num[2][3];//横列の和より位置8の値を計算
                if (num[2][4]<1) break;
                if (num[2][4]>16||used[num[2][4]]||num[2][4]==num[2][1]) continue;
                num[3][1]=34-num[1][1]-num[2][1]-num[4][1];//縦列の和より位置9の値を計算
                if (num[3][1]<1) break;
                if (num[3][1]>16||used[num[3][1]]||num[3][1]==num[2][1] || num[3][1]==num[2][4]) continue;
                num[3][4]=34-num[1][4]-num[2][4]-num[4][4];//縦列の和より位置12の値を計算
                if (num[3][4]>16) break;
                if (num[3][4]<1||used[num[3][4]]||num[3][4]==num[2][1] || num[3][4]==num[2][4] || num[3][4]==num[3][1]) continue;
                count++;
                //魔方陣が完成したらカウントを増やし、MS[魔方陣番号(1～880）][魔方陣の位置]とする
                for (int j=1; j<=4; j++) {
                  for (int i=1; i<=4; i++) {
                    MS[count][i+4*(j-1)]=num[j][i];
                  }
                }
              }
              used[num[2][3]]=used[num[3][2]]=used[num[4][3]]=used[num[4][2]]=false;     // フラグを降ろす
            }
            used[num[1][2]]=used[num[1][3]]=false;
          }
          used[num[2][2]]=used[num[3][3]]=false;
        }
        used[num[4][1]]=used[num[4][4]]=false;
      }
      used[num[1][4]]=false;
    }
    used[num[1][1]]=false;
  }

  //MSの種類算出　配列の初期化
  MS1=new int[250][17];
  MS2=new int[250][17];
  MS3=new int[40][17];
  MS5=new int[15][17];
  MS6=new int[5][17];
  MS7=new int[5][17];
  MS9=new int[5][17];
  ans=new int[17][17];
  ans2=new int[17][17];
  ans3=new int[17][17][17];
  ans5=new int[17][17][17][17];
  ans6=new int[17][17][17][17][17];
  ans7=new int[17][17][17][17][17][17];
  ans9=new int[8][17][17][17][17][17][17];

  for (int i=1; i<=16; i++) {
    int count1=0;
    for (int j=1; j<=880; j++) {
      if (MS[j][1]==i) {
        count1++;
        for (int k=1; k<=16; k++) {//魔方陣が成り立つものがあれば、MS1に格納
          MS1[count1][k]=MS[j][k];
        }
      }
    }
    ans[1][i]=count1;
    if (ans[1][i]==0) {
      for (int a=2; a<=16; a++) {
        ans[a][i]=0;
      }
    } else {
      for (int i2=1; i2<=16; i2++) {
        int count2=0;
        for (int j=1; j<=count1; j++) {
          if (MS1[j][2]==i2) {
            count2++;
            for (int k=1; k<=16; k++) {//魔方陣が成り立つものがあれば、MS2に格納
              MS2[count2][k]=MS1[j][k];
            }
          }
        }
        ans2[i][i2]=count2;
        if (ans2[i][i2]!=0) {
          for (int i3=1; i3<=16; i3++) {
            int count3=0;
            for (int j=1; j<=count2; j++) {
              if (MS2[j][3]==i3) {
                count3++;
                for (int k=1; k<=16; k++) {//魔方陣が成り立つものがあれば、MS3に格納
                  MS3[count3][k]=MS2[j][k];
                }
              }
            }
            ans3[i][i2][i3]=count3;
            if (ans3[i][i2][i3]!=0) {
              for (int i5=1; i5<=16; i5++) {
                int count5=0;
                for (int j=1; j<=count3; j++) {
                  if (MS3[j][5]==i5) {
                    count5++;
                    for (int k=1; k<=16; k++) {//魔方陣が成り立つものがあれば、MS5に格納
                      MS5[count5][k]=MS3[j][k];
                    }
                  }
                }
                ans5[i][i2][i3][i5]=count5;
                if (ans5[i][i2][i3][i5]!=0) {
                  for (int i6=1; i6<=16; i6++) {
                    int count6=0;
                    for (int j=1; j<=count5; j++) {
                      if (MS5[j][6]==i6) {
                        count6++;
                        for (int k=1; k<=16; k++) {//魔方陣が成り立つものがあれば、MS6に格納
                          MS6[count6][k]=MS5[j][k];
                        }
                      }
                    }
                    ans6[i][i2][i3][i5][i6]=count6;
                    if (ans6[i][i2][i3][i5][i6]!=0) {
                      for (int i7=1; i7<=16; i7++) {
                        int count7=0;
                        for (int j=1; j<=count6; j++) {
                          if (MS6[j][7]==i7) {
                            count7++;
                            for (int k=1; k<=16; k++) {//魔方陣が成り立つものがあれば、MS7に格納
                              MS7[count7][k]=MS6[j][k];
                            }
                          }
                        }

                        ans7[i][i2][i3][i5][i6][i7]=count7;
                        if (ans7[i][i2][i3][i5][i6][i7]!=0) {
                          //int i8=34-i5-i6-i7;
                          for (int i9=1; i9<=16; i9++) {
                            int count9=0;
                            for (int j=1; j<=count7; j++) {
                              if (MS7[j][9]==i9) {
                                count9++;
                                for (int k=1; k<=16; k++) {//魔方陣が成り立つものがあれば、MS9に格納
                                  MS9[count9][k]=MS7[j][k];
                                }
                              }
                            }
                            ans9[i][i2][i3][i5][i6][i7][i9]=count9;
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

void draw() {
  /*Mode1=1のときスタート画面を表示*/
  if (Mode1==1) {
    cl();
    textAlign(CENTER, CENTER);
    textSize(50);
    text("魔方陣", width/2, 100);
    textSize(30);
    text("～誰でも簡単に魔方陣が作れる!～", width/2, 150);
    textSize(20);
    textAlign(LEFT);
    text("縦・横・斜めの和がどこも等しくなる", width/2-50, 230);
    text("ように1〜16までの数をうめよ!", width/2-50, 250);
    text("全部で880種類", width/2-50, 270);
    textAlign(CENTER, CENTER);
    int ulx2=60;  //例としての魔方陣を絵画
    int uly2=190;
    int int2=30;//魔方陣の縦幅、横幅
    for (int i=0; i<=4; i++) {
      line(ulx2+int2*i, uly2, ulx2+int2*i, uly2+int2*4);
      line(ulx2, uly2+int2*i, ulx2+int2*4, uly2+int2*i);
    }
    for (int i=1; i<=16; i++) {//魔方陣を出力
      if (i%4==0)text(MS[1][i], 75+int2*3, 205+int2*floor((i-1)/4));
      else text(MS[1][i], 75+int2*((i%4)-1), 205+int2*floor((i-1)/4));
    }
    stroke(0);
    strokeWeight(3);
    noFill();
    rect(100, 330, 160, 90);
    rect(340, 330, 160, 90);
    textSize(30);
    text("ルール説明", 180, 375); 
    text("スタート", 420, 375);  
    textSize(25);
    text("「r」キー", 180, 440); 
    text("右クリック", 420, 440);  
    /*ボタン操作右クリックしたときにはメイン(ゲーム)画面へ、rキーを押したときはルール説明画面へ遷移するようにする*/
    if (mouseButton==RIGHT) {
      Mode1++;
    }
    if (key=='r') {
      Moder=true;
    }
  }
    /*ルール説明画面表示(rキーで)*/
  if (Moder==true) {
    cl();
    textAlign(CENTER, CENTER);
    textSize(40);
    text("ルール説明", width/2, 50);
    textSize(30);
    text("数字入力", width/2, 100);
    textSize(20);
    text("1〜9まではそのまま入力、10以上の数は", width/2, 140);   
    text("A=10,B=11,C=12,D=13,E=14,F=15,G=16とする ", width/2, 180);
    text("1,3列目では「→」、2,4列目では「↓」を押すことで確定", width/2, 220);
    textSize(30);
    text("条件", width/2, 280);
    textSize(20);
    text("(左上の値)<(右上の値)<(左下の値)", width/2, 320);  
    text("(左上の値)<(右下の値)とする", width/2, 360);   
    textSize(15);
    text("回転・裏返ししたものは同一のものとみなすため ", width/2, 400);
    //枠作る
    stroke( 0);
    strokeWeight(3);
    noFill();
    rect(35, 81, 540, 170);//数字入力の部分
    rect(35, 260, 540, 170);//条件の部分 
    textSize(25);
    text("ENTERキーでスタート画面に戻る", width/2, 450);
    if (key==ENTER) {
      Moder=false;//スタート画面に戻る
    }
  }  
  /*メイン(ゲーム)画面*/
  if (Mode1>1&&Mode1<10) {
    background(200);//文字の重なりを防止(11)
    MSdraw();  /*MSの概形を描画*/
    if (key=='h')Modeh=true;
    /*ヘルプ画面 hキーを押したら表示　メイン画面の簡単な説明*/
    if (Modeh==true) {//help画面　魔方陣メイン画面でのみ実行
      cl();
      textAlign(CENTER, CENTER);
      stroke(0);
      MSdraw();
      fill(255);//ここで加える説明は白文字
      textSize(20);
      text("Enterでもとに戻る", width/2, 10);
      stroke(255);
      strokeWeight(3);
      noFill();
      rect(30, 30, 75, 60);//種類数の枠
      textSize(25);
      text("種類数", 70, 110);
      textSize(20);
      text("入力した値の", 70, 135);  
      text("組で成り立つ", 70, 155);   
      text("魔方陣の種類数", 70, 175);

      rect(200, 30, 200, 30);//MS可否条件の枠
      text("魔方陣の成否表示", width/2, 70);  

      ellipse(width/2, 440, 290, 80);//列の和の枠
      text("各列の和", width/2, 410);  
      ellipse(475, 250, 55, 300);//縦の和の枠
      text("各行の和", 550, height/2);  
      ellipse(125, 440, 50, 50);//斜めの和1の枠
      ellipse(475, 440, 50, 50);//斜めの和2の枠
      if (key==ENTER) { //Enterキーを押したら戻す
        Modeh=false;
        stroke(0);
      }
    }
    textSize(20);
    text("hキーでHelp画面", width/2, 460);
    //文字の基本設定(フォント,色)
    fill(0);
    sum();
    textSize(50);

    if (Mode==1) {//位置1の値の判定
      if (key!=CODED) {
        MSdisplay();//そのModeの魔方陣の値を表示する。もし、魔方陣が成立しない場合は「魔方陣:不成立」と出力する。
        text(ans[1][k[1]], 70, 80);//条件を満たす魔方陣の種類数を出力
        textSize(20);
        if (ans[1][k[1]]==0)text("魔方陣：不成立", 300, 50);//もし、条件を満たしていなければ「魔方陣:不成立」と出力
        textSize(50);
      } else if (keyCode==RIGHT) {//「→」を押すと次のモードに移り次の数字の判定ができる。
        Mode++;
      }
    }
    if (Mode==2) {//位置2の値の判定
      MSdis2();//前のモードまでに入っていた数字を出力
      if (key!=CODED) {
        MSdisplay();
        text(ans2[k[1]][k[2]], 70, 80);
        textSize(20);
        if (ans2[k[1]][k[2]]==0)text("魔方陣：不成立", 300, 50);
        textSize(50);
      } else if (keyCode==DOWN) {//「↓」を押すと次のモードに移り次の数字の判定ができる。
        Mode++;
      }
    }
    if (Mode==3) {//位置3の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        text(ans3[k[1]][k[2]][k[3]], 70, 80);
        textSize(20);
        if (ans3[k[1]][k[2]][k[3]]==0)text("魔方陣：不成立", 300, 50);
        textSize(50);
      } else if (keyCode==RIGHT) {
        Mode++;
      }
    }
    if (Mode==4) {//位置4の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        if ((34-k[1]-k[2]-k[3])==k[4]) text(ans3[k[1]][k[2]][k[3]], 70, 80);
        else judge() ;
      } else if (keyCode==DOWN) {
        Mode++;
      }
    }
    if (Mode==5) {//位置5の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        text(ans5[k[1]][k[2]][k[3]][k[5]], 70, 80);
        textSize(20);
        if (ans5[k[1]][k[2]][k[3]][k[5]]==0)text("魔方陣：不成立", 300, 50);
        textSize(50);
      } else if (keyCode==RIGHT) {
        Mode++;
      }
    }
    if (Mode==6) {//位置6の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        text(ans6[k[1]][k[2]][k[3]][k[5]][k[6]], 70, 80);
        textSize(20);
        if (ans6[k[1]][k[2]][k[3]][k[5]][k[6]]==0)text("魔方陣：不成立", 300, 50);
        textSize(50);
      } else if (keyCode==DOWN) {
        Mode++;
      }
    }
    if (Mode==7) {//位置7の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        text(ans7[k[1]][k[2]][k[3]][k[5]][k[6]][k[7]], 70, 80);
        textSize(20);
        if (ans7[k[1]][k[2]][k[3]][k[5]][k[6]][k[7]]==0)text("魔方陣：不成立", 300, 50);
        textSize(50);
      } else if (keyCode==RIGHT) {
        Mode++;
      }
    }
    if (Mode==8) {//位置8の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        if ((34-k[5]-k[6]-k[7])==k[8])text(ans7[k[1]][k[2]][k[3]][k[5]][k[6]][k[7]], 70, 80);
        else judge() ;
      } else if (keyCode==DOWN) {
        Mode++;
      }
    }
    if (Mode==9) {//位置9の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        if (k[1]>7)text(0, 70, 80);
        else text(ans9[k[1]][k[2]][k[3]][k[5]][k[6]][k[7]][k[9]], 70, 80);
        textSize(20);
        if (ans9[k[1]][k[2]][k[3]][k[5]][k[6]][k[7]][k[9]]==0)text("魔方陣：不成立", 300, 50);
        textSize(50);
      } else if (keyCode==RIGHT) {
        Mode++;
      }
    }
    if (Mode==10) {//位置10の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        if (k[4]+k[7]+k[10]+(34-k[1]-k[5]-k[9])==34)text(ans9[k[1]][k[2]][k[3]][k[5]][k[6]][k[7]][k[9]], 70, 80);//ansの部分は9に変更
        else judge() ;
      } else if (keyCode==DOWN) {
        Mode++;
      }
    }
    if (Mode==11) {//位置11の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        if ((k[6]+k[7]+k[10]+k[11])==34)text(ans9[k[1]][k[2]][k[3]][k[5]][k[6]][k[7]][k[9]], 70, 80);//ansの部分は9に変更
        else judge() ;
      } else if (keyCode==RIGHT) {
        Mode++;
      }
    }
    if (Mode==12) {//位置12の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        if ((k[9]+k[10]+k[11]+k[12])==34)text(ans9[k[1]][k[2]][k[3]][k[5]][k[6]][k[7]][k[9]], 70, 80);//ansの部分は9に変更
        else judge() ;
      } else if (keyCode==DOWN) {
        Mode++;
      }
    }
    if (Mode==13) {//位置13の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        if ((k[1]+k[5]+k[9]+k[13])==34)text(ans9[k[1]][k[2]][k[3]][k[5]][k[6]][k[7]][k[9]], 70, 80);//ansの部分は9に変更
        else judge() ;
      } else if (keyCode==RIGHT) {
        Mode++;
      }
    }
    if (Mode==14) {//位置14の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        if ((k[2]+k[6]+k[10]+k[14])==34)text(ans9[k[1]][k[2]][k[3]][k[5]][k[6]][k[7]][k[9]], 70, 80);//ansの部分は9に変更
        else judge() ;
      } else if (keyCode==DOWN) {
        Mode++;
      }
    }
    if (Mode==15) {//位置15の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        if ((k[3]+k[7]+k[11]+k[15])==34)text(ans9[k[1]][k[2]][k[3]][k[5]][k[6]][k[7]][k[9]], 70, 80);//ansの部分は9に変更
        else judge() ;
      } else if (keyCode==RIGHT) {
        Mode++;
      }
    }
    if (Mode==16) {//位置16の値の判定
      MSdis2();
      if (key!=CODED) {
        MSdisplay();
        if ((k[4]+k[8]+k[12]+k[16])==34) {
          text("魔方陣 完成!", 300, 60);
          noFill();
          stroke(255, 0, 0);
          strokeWeight(3);
          rect(140, 10, 320, 80);
        } else judge() ;
      }
    }
  }
}
void MSdraw() {
  /*MSを描画*/
  int n=4;//魔方陣の次数（列数）
  for (int i=0; i<=n; i++) {
    line(ulx+intx*i, uly, ulx+intx*i, uly+inty*n);
    line(ulx, uly+inty*i, ulx+intx*n, uly+inty*i);
  }
}

void sum() {//魔方陣の定和表示
  textSize(40);
  for (int i=0; i<4; i++) {//横の和
    text(k[4*i+1]+k[4*i+2]+k[4*i+3]+k[4*i+4], textx+intx*4, texty+inty*i) ;
  }
  for (int i=1; i<=4; i++) {//縦の和
    text(k[i]+k[4+i]+k[8+i]+k[12+i], textx+intx*(i-1), texty+inty*4) ;
  }
  text(k[1]+k[6]+k[11]+k[16], textx+intx*4, texty+inty*4);//斜めの和
  text(k[4]+k[7]+k[10]+k[13], textx-intx, texty+inty*4);
}

void MSdisplay() { //そのModeの魔方陣の値を表示する。もし、魔方陣が成立しない場合は「魔方陣:不成立」と出力する。
  k[Mode]=key-48;
  if (k[Mode]>=49&&k[Mode]<=55)k[Mode]-=39;//a=10,b=11,c=12,d=13,e=14,f=15,g=16とする
  else if (k[Mode]<0||k[Mode]>9) {
    k[Mode]=0;
    textAlign(CENTER);
    textSize(20);
    text("魔方陣：不成立", 300, 50);
    textSize(50);
  }
  textAlign(CENTER);
  if (Mode%4==0)text(k[Mode], textx+intx*3, texty+inty*floor((Mode-1)/4));
  else text(k[Mode], textx+intx*((Mode%4)-1), texty+inty*floor((Mode-1)/4));
}

void MSdis2() {//前のモードまでに入っていた数字を出力
  for (int i=1; i<Mode; i++) {
    if (i%4==0)text(k[i], textx+intx*3, texty+inty*floor((i-1)/4));
    else text(k[i], textx+intx*((i%4)-1), texty+inty*floor((i-1)/4));
  }
}

void judge() {//他に依存する値の入力場所において、不成立なら種類数は0と表示し、不成立と出力する
  text(0, 70, 80);
  textSize(20);
  text("魔方陣：不成立", 300, 50);
  textSize(50);
}

void cl() {//背景の色を一括指定
  background(130, 130, 250);
}
