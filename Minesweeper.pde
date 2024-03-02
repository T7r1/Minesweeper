import de.bezier.guido.*;
public final static int NUM_ROWS =20;
public final static int NUM_COLS =20;
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
  while (mines.size()<20){
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
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    //your code here
    
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
for (int u=-1;u<=1;u++)
  for (int i=-1;i<=1;i++)
  if(col-i>=0&&col-i<NUM_ROWS&&row-u>=0&&row-u<NUM_COLS&&(i!=0||u!=0))
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
        clicked = true;
        //your code here
        if(countMines(myRow,myCol)==0){
          System.out.println(countMines(myRow,myCol));
//          for (int i=-1;i<1;i++)
//          for (int u=-1;u<1;u++)
//          if (myCol-u>=0&&myCol-u<NUM_ROWS&&myRow-i>=0&&myRow-i<NUM_COLS){
//buttons[myRow-i][myCol-u].mousePressed();
//        System.out.println((myCol-u)+", "+(myRow-i));  
//        }



//for (int u=-1; u<=1; u++) 
//        for (int i=-1; i<=1; i++) 
//          if (myCol-i>=0&&myCol-i<NUM_ROWS&&myRow-u>=0&&myRow-u<NUM_COLS&&(i!=0||u!=0)) {
//            System.out.println((myRow-u)+", "+(myCol-i));
            buttons[myRow][myCol-1].mousePressed();  
                        buttons[myRow-1][myCol-1].mousePressed();        
            buttons[myRow][myCol+1].mousePressed();        
            buttons[myRow-1][myCol].mousePressed();        
            buttons[myRow+1][myCol].mousePressed();        
            //buttons[myRow-1][myCol-1].mousePressed();        
            //buttons[myRow-1][myCol-1].mousePressed();        
            //buttons[myRow-1][myCol-1].mousePressed();        

      //}



    }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
         else if(  mines.contains(this) ) {
             fill(255,0,0);
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
        public boolean isMined(){
        return mines.contains(this);
        }

}

