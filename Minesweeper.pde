import de.bezier.guido.*;
public final static int NUM_ROWS =10;
public final static int NUM_COLS =10;
public boolean play=true;
public int score=0;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines=new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    buttons=new MSButton[NUM_ROWS][NUM_COLS];
    //your code to initialize buttons goes here
          for (int i=0;i<NUM_ROWS;i++){
    for (int u=0;u<NUM_COLS;u++){
buttons [i][u]=new MSButton(i,u);
    }
          }
    setMines();
}
public void setMines()
{
  while (mines.size()<NUM_ROWS*NUM_COLS/9){
int r=(int)(Math.random()*(NUM_ROWS));
int c=(int)(Math.random()*(NUM_COLS));
if(!mines.contains(this)){
mines.add(buttons[r][c]);
//System.out.println(c+", "+r);
}
  }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
 for (int i=0;i<NUM_ROWS;i++)
    for (int u=0;u<NUM_COLS;u++)
    if (!buttons[i][u].isMined()&&!buttons[i][u].isClicked())
    return false;
    return true;
}
public void displayLosingMessage()
{
    //your code here
    for (int i=0;i<NUM_ROWS;i++)
    for (int u=0;u<NUM_COLS;u++)
    buttons[i][u].setLabel("X");
    //fill(100,255,255);
    //rect(0,0,width,height);
}
public void displayWinningMessage()
{
   for (int i=0;i<NUM_ROWS;i++)
    for (int u=0;u<NUM_COLS;u++)
    buttons[i][u].setLabel("√");
    //your code here
}
public boolean isValid(int r, int c)
{
    //your code here
    return r>=0&&r<NUM_ROWS&&c>=0&&c<NUM_COLS;
}
public int countMines(int row, int col)
{
    int numMines = 0;
for (int u=-1;u<=1;u++)
  for (int i=-1;i<=1;i++)
  if(isValid(row-u,col-i)&&(i!=0||u!=0))
  if (buttons[row-u][col-i].isMined()==true){
  numMines++;}
  return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
              int count=countMines(myRow,myCol);
        //your code here
        if(play||!isWon()){
          if(mouseButton == LEFT){
            flagged=false;
                    clicked = true;

        if (isMined()){
        play=false;
      }
        else if(count==0){
for (int u=-1; u<=1; u++) {
        for (int i=-1; i<=1; i++) {
          if (isValid(myRow-u,myCol-i)&&buttons[myRow-u][myCol-i].isClicked()==false) {
          //  System.out.println((myCol-i)+", "+(myRow-u));
            buttons[myRow-u][myCol-i].mousePressed();

      }
        }


    }
        }
        
        else if(count>0)
    setLabel(count);
        }else
        flagged=!flagged;
        }
   // System.out.println("HELP");
    }
    public void draw () 
    {    
      if(isWon()){
      System.out.print("help");
displayWinningMessage();
      } if (flagged&&!clicked&&play&&!isWon())
            fill(255,255,0);
         else if( (clicked||!play)&& mines.contains(this) ) {
             fill(255,0,0);
                   displayLosingMessage();  

            // System.out.println(buttons[myRow][myCol].isMined());
    }else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
     public boolean isClicked(){
          return clicked;
        }
        public boolean isMined(){
        return mines.contains(this);
        }

}
