//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package io.netty.buffer;

import io.netty.util.internal.PlatformDependent;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.ByteBuffer;

public class UnpooledUnsafeDirectByteBuf extends UnpooledDirectByteBuf {
    long memoryAddress;

    public UnpooledUnsafeDirectByteBuf(ByteBufAllocator alloc, int initialCapacity, int maxCapacity) {
        super(alloc, initialCapacity, maxCapacity);
    }

    protected UnpooledUnsafeDirectByteBuf(ByteBufAllocator alloc, ByteBuffer initialBuffer, int maxCapacity) {
        super(alloc, initialBuffer, maxCapacity, false, true);
    }

    UnpooledUnsafeDirectByteBuf(ByteBufAllocator alloc, ByteBuffer initialBuffer, int maxCapacity, boolean doFree) {
        super(alloc, initialBuffer, maxCapacity, doFree, false);
    }

    final void setByteBuffer(ByteBuffer buffer, boolean tryFree) {
        super.setByteBuffer(buffer, tryFree);
        this.memoryAddress = PlatformDependent.directBufferAddress(buffer);
    }

    public boolean hasMemoryAddress() {
        return true;
    }

    public long memoryAddress() {
        this.ensureAccessible();
        return this.memoryAddress;
    }

    public byte getByte(int index) {
        this.checkIndex(index);
        return this._getByte(index);
    }

    protected byte _getByte(int index) {
        return UnsafeByteBufUtil.getByte(this.addr(index));
    }

    public short getShort(int index) {
        this.checkIndex(index, 2);
        return this._getShort(index);
    }

    protected short _getShort(int index) {
        return UnsafeByteBufUtil.getShort(this.addr(index));
    }

    protected short _getShortLE(int index) {
        return UnsafeByteBufUtil.getShortLE(this.addr(index));
    }

    public int getUnsignedMedium(int index) {
        this.checkIndex(index, 3);
        return this._getUnsignedMedium(index);
    }

    protected int _getUnsignedMedium(int index) {
        return UnsafeByteBufUtil.getUnsignedMedium(this.addr(index));
    }

    protected int _getUnsignedMediumLE(int index) {
        return UnsafeByteBufUtil.getUnsignedMediumLE(this.addr(index));
    }

    public int getInt(int index) {
        this.checkIndex(index, 4);
        return this._getInt(index);
    }

    protected int _getInt(int index) {
        return UnsafeByteBufUtil.getInt(this.addr(index));
    }

    protected int _getIntLE(int index) {
        return UnsafeByteBufUtil.getIntLE(this.addr(index));
    }

    public long getLong(int index) {
        this.checkIndex(index, 8);
        return this._getLong(index);
    }

    protected long _getLong(int index) {
        return UnsafeByteBufUtil.getLong(this.addr(index));
    }

    protected long _getLongLE(int index) {
        return UnsafeByteBufUtil.getLongLE(this.addr(index));
    }

    public ByteBuf getBytes(int index, ByteBuf dst, int dstIndex, int length) {
        UnsafeByteBufUtil.getBytes(this, this.addr(index), index, dst, dstIndex, length);
        return this;
    }

    void getBytes(int index, byte[] dst, int dstIndex, int length, boolean internal) {
        UnsafeByteBufUtil.getBytes(this, this.addr(index), index, dst, dstIndex, length);
    }

    void getBytes(int index, ByteBuffer dst, boolean internal) {
        UnsafeByteBufUtil.getBytes(this, this.addr(index), index, dst);
    }

    public ByteBuf setByte(int index, int value) {
        this.checkIndex(index);
        this._setByte(index, value);
        return this;
    }

    protected void _setByte(int index, int value) {
        UnsafeByteBufUtil.setByte(this.addr(index), value);
    }

    public ByteBuf setShort(int index, int value) {
        this.checkIndex(index, 2);
        this._setShort(index, value);
        return this;
    }

    protected void _setShort(int index, int value) {
        UnsafeByteBufUtil.setShort(this.addr(index), value);
    }

    protected void _setShortLE(int index, int value) {
        UnsafeByteBufUtil.setShortLE(this.addr(index), value);
    }

    public ByteBuf setMedium(int index, int value) {
        this.checkIndex(index, 3);
        this._setMedium(index, value);
        return this;
    }

    protected void _setMedium(int index, int value) {
        UnsafeByteBufUtil.setMedium(this.addr(index), value);
    }

    protected void _setMediumLE(int index, int value) {
        UnsafeByteBufUtil.setMediumLE(this.addr(index), value);
    }

    public ByteBuf setInt(int index, int value) {
        this.checkIndex(index, 4);
        this._setInt(index, value);
        return this;
    }

    protected void _setInt(int index, int value) {
        UnsafeByteBufUtil.setInt(this.addr(index), value);
    }

    protected void _setIntLE(int index, int value) {
        UnsafeByteBufUtil.setIntLE(this.addr(index), value);
    }

    public ByteBuf setLong(int index, long value) {
        this.checkIndex(index, 8);
        this._setLong(index, value);
        return this;
    }

    protected void _setLong(int index, long value) {
        UnsafeByteBufUtil.setLong(this.addr(index), value);
    }

    protected void _setLongLE(int index, long value) {
        UnsafeByteBufUtil.setLongLE(this.addr(index), value);
    }

    public ByteBuf setBytes(int index, ByteBuf src, int srcIndex, int length) {
        UnsafeByteBufUtil.setBytes(this, this.addr(index), index, src, srcIndex, length);
        return this;
    }

    public ByteBuf setBytes(int index, byte[] src, int srcIndex, int length) {
        UnsafeByteBufUtil.setBytes(this, this.addr(index), index, src, srcIndex, length);
        return this;
    }

    public ByteBuf setBytes(int index, ByteBuffer src) {
        UnsafeByteBufUtil.setBytes(this, this.addr(index), index, src);
        return this;
    }

    void getBytes(int index, OutputStream out, int length, boolean internal) throws IOException {
        UnsafeByteBufUtil.getBytes(this, this.addr(index), index, out, length);
    }

    public int setBytes(int index, InputStream in, int length) throws IOException {
        return UnsafeByteBufUtil.setBytes(this, this.addr(index), index, in, length);
    }

    public ByteBuf copy(int index, int length) {
        return UnsafeByteBufUtil.copy(this, this.addr(index), index, length);
    }

    final long addr(int index) {
        return this.memoryAddress + (long)index;
    }

    protected SwappedByteBuf newSwappedByteBuf() {
        return (SwappedByteBuf)(PlatformDependent.isUnaligned() ? new UnsafeDirectSwappedByteBuf(this) : super.newSwappedByteBuf());
    }

    public ByteBuf setZero(int index, int length) {
        this.checkIndex(index, length);
        UnsafeByteBufUtil.setZero(this.addr(index), length);
        return this;
    }

    public ByteBuf writeZero(int length) {
        this.ensureWritable(length);
        int wIndex = this.writerIndex;
        UnsafeByteBufUtil.setZero(this.addr(wIndex), length);
        this.writerIndex = wIndex + length;
        return this;
    }
}
