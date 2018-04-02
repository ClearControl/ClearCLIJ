__kernel void downsample_3d_nearest(write_only image3d_t dst, read_only image3d_t src, float factor_x, float factor_y, float factor_z) {
  const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

  const int dx = get_global_id(0);
  const int dy = get_global_id(1);
  const int dz = get_global_id(2);

  const int sx = factor_x * dx;
  const int sy = factor_y * dy;
  const int sz = factor_z * dz;
  const DTYPE_IN out = READ_IMAGE(src,sampler,(int4)(sx,sy,sz,0)).x;
  WRITE_IMAGE(dst,(int4)(dx,dy,dz,0),(DTYPE_OUT)out);
}

__kernel void downsample_2d_nearest(write_only image2d_t dst, read_only image2d_t src, float factor_x, float factor_y) {
  const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

  const int dx = get_global_id(0);
  const int dy = get_global_id(1);

  const int sx = factor_x * dx;
  const int sy = factor_y * dy;
  const DTYPE_IN out = READ_IMAGE(src,sampler,(int2)(sx,sy)).x;
  WRITE_IMAGE(dst,(int2)(dx,dy),(DTYPE_OUT)out);
}
