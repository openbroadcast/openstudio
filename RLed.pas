unit RLed;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,comctrls;

type
  TRLed = class(TGraphicControl)
  private
    FColorLow: TColor;
    FColorHi: TColor;
    FOrientation: TTrackBarOrientation;
    FMaxValue: Longint;
    FBackColor: TColor;
    FBarSize: word;
    FPosition: longint;
    FBreakPos: byte;
    procedure SetColorHi(const Value: TColor);
    procedure SetColorLow(const Value: TColor);
    procedure SetOrientation(const Value: TTrackBarOrientation);
    procedure SetMaxValue(const Value: Longint);
    procedure SetBackColor(const Value: TColor);
    procedure SetBarSize(const Value: word);
    procedure SetPosition(const Value: longint);
    procedure SetBreakPos(const Value: byte);
    { Private declarations }
  protected
    { Protected declarations }
    BarCount:longint;
    procedure Paint; override;
    procedure RecalcBarCount;
    function BlendColor(clr: TColor): TColor;
    function inHi(I: Integer;Pro:byte): boolean;
  public
    { Public declarations }
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function InPos(i: Integer): boolean;
  published
    { Published declarations }
    property ColorLow:TColor read FColorLow write SetColorLow;
    property ColorHi:TColor read FColorHi write SetColorHi;
    property Orientation:TTrackBarOrientation read FOrientation write SetOrientation default trVertical;
    property MaxValue: Longint read FMaxValue write SetMaxValue;
    property BackColor:TColor read FBackColor write SetBackColor;
    property BarSize:word read FBarSize write SetBarSize;
    property Position:longint read FPosition write SetPosition;
    property BreakPos:byte read FBreakPos write SetBreakPos;
    property Constraints;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property Align;
    property Anchors;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property DragCursor;
    property DragKind;
    property DragMode;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('CST-Tech', [TRLed]);
end;

{ TRLed }

function TRLed.BlendColor(clr: TColor): TColor;
begin
Result:=rgb(GetRValue(clr) div 3,GetgValue(clr)div 3,GetbValue(clr)div 3);
end;

constructor TRLed.Create(Owner: TComponent);
begin
inherited CReate(Owner);
Width := 25;  // Change inherited properties
Height := 152;
FMaxValue:=100;
FBackColor:=clBlack;
FColorLow:=clLime;
FColorHi:=clRed;
rgb(255,0,0);
FBarSize:=5;
FOrientation:=trVertical;
FPOsition:=0;
FBreakPos:=35;
RecalcBarCount;
end;

destructor TRLed.Destroy;
begin
inherited Destroy;
end;

function TRLed.inHi;
begin
result:=i<Round(BarCount/100*Pro);
end;

function TRLed.InPos(i: Integer): boolean;
var bTemp:byte;
begin
bTemp:=round((FPosition / FMaxValue) * 100);
result:=i>BarCount-Round(BarCount/100*bTemp);
end;

procedure TRLed.Paint;
var TB:TBitmap;
    i:word;
begin
TB:=TBitmap.create;
tb.Width:=Width;
tb.Height:=Height;
tb.Canvas.Brush.Color:=BAckColor;
tb.Canvas.FillRect(rect(0,0,Width,Height));
RecalcBarCount;
case FOrientation of
trVertical:begin
                for i:=1 to BarCount do
                begin
                if inHi(i,FBreakPos) then if not InPos(i) then tb.Canvas.Brush.Color:=BlendCOlor(ColorHi)
                                     else tb.Canvas.Brush.Color:=ColorHi
                                     else if not InPos(i) then tb.Canvas.Brush.Color:=BlendCOlor(ColorLow)
                          else tb.Canvas.Brush.Color:=ColorLow;
                          tb.Canvas.FillRect(rect(2,(i-1)*barSize+2,width-2,(i-1)*barSize+BarSize));
                          end;
                 end;
trHorizontal:begin
                for i:=1 to BarCount do
                begin
                if inHi(BarCount-i,FBreakPos) then if not InPos(BarCount-i+1) then tb.Canvas.Brush.Color:=BlendCOlor(ColorHi)
                                     else tb.Canvas.Brush.Color:=ColorHi
                                     else if not InPos(BarCount-i+1) then tb.Canvas.Brush.Color:=BlendCOlor(ColorLow)
                          else tb.Canvas.Brush.Color:=ColorLow;
                          tb.Canvas.FillRect(rect((i-1)*barSize+2,2,(i-1)*barSize+BarSize,height-2));
                          end;
                  end;
end;
Canvas.CopyRect(Rect(0,0,width,height),tb.canvas,Rect(0,0,width,height));
TB.free;
end;

procedure TRLed.RecalcBarCount;
begin
if FOrientation=trVertical then
BarCount:=(Height-2) div (FBarSize)
else
BarCount:=(Width-2) div (FBarSize)
end;

procedure TRLed.SetBackColor(const Value: TColor);
begin
  FBackColor := Value;
  paint;
end;

procedure TRLed.SetBarSize(const Value: word);
begin
  if (FBarSize <> Value) and
  ((FOrientation=trVertical)
  and
  (Value<Height-4))
  or
  ((FOrientation=trHorizontal)
  and
  (Value<Width-4))
  then
  begin
  FBarSize := Value;
  RecalcBarCount;
  Paint;
  end;
end;

procedure TRLed.SetBreakPos(const Value: byte);
begin
  if not Value>100 then
  begin
  FBreakPos := Value;
  Paint;
  end;
end;

procedure TRLed.SetColorHi(const Value: TColor);
begin
  FColorHi := Value;
  Paint;
end;

procedure TRLed.SetColorLow(const Value: TColor);
begin
  if FColorLow <>Value then
  begin
  FColorLow := Value;
  Paint;
  end;
end;

procedure TRLed.SetMaxValue(const Value: Longint);
begin
  if FMaxValue <> Value then
  begin
  FMaxValue := Value;
  Paint;
  end;
end;

procedure TRLed.SetOrientation(const Value: TTrackBarOrientation);
begin
  if FOrientation <> Value then
  begin
  FOrientation := Value;
   //Change Orientation
    if ComponentState * [csLoading, csUpdating] = [] then
      SetBounds(Left, Top, Height, Width);
  Paint;
  end;
end;

procedure TRLed.SetPosition(const Value: longint);
begin
  if Value<=FMaxValue then
     begin
     FPosition := Value;
     Paint;
     end;
end;

end.
