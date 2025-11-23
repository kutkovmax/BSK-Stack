class BSKStack {
  constructor(whiteRatio=0.3, blueRatio=0.4){
    this.data = []; // [{color:'W', value:...}, ...]
    this.whiteRatio = whiteRatio;
    this.blueRatio = blueRatio;
  }
  zones() {
    const n = this.data.length;
    const w = Math.floor(n * this.whiteRatio);
    const b = Math.floor(n * (this.whiteRatio + this.blueRatio));
    return [w,b];
  }
  push(v) {
    this.data.unshift({color:'W', value:v});
  }
  pop() {
    if(this.data.length === 0) return null;
    const [w,b] = this.zones();
    for(let i=0;i<Math.min(w,this.data.length);i++){
      if(this.data[i].color === 'W' || this.data[i].color === 'B'){
        return this.data.splice(i,1)[0].value;
      }
    }
    for(let i=w;i<Math.min(b,this.data.length);i++){
      if(this.data[i].color === 'B'){
        return this.data.splice(i,1)[0].value;
      }
    }
    throw new Error("Red zone locked");
  }
  updateColors(){
    const [w,b] = this.zones();
    for(let i=0;i<this.data.length;i++){
      if(i < w) this.data[i].color='W';
      else if(i < b) this.data[i].color='B';
      else this.data[i].color='R';
    }
  }
  size(){ return this.data.length; }
}
module.exports = BSKStack;